-- drop tables
do $$
begin
    execute coalesce(
        (
            SELECT string_agg('drop table if exists "' || table_name || '" cascade;', '')
            FROM information_schema.tables
            WHERE table_schema = 'public'
        ),
        ''
    );
end
$$ language plpgsql;


create table if not exists "user" (
    id serial primary key,
    login varchar(255) unique not null,
    name varchar(255) not null default 'Anonymous',
    password_hash varchar(88) not null, -- 512 bits in base64
    money bigint not null default 0
--     level int not null default 1
);

create table if not exists tea (
    id serial primary key,
    name varchar(255) not null,
    price bigint not null default 0,
    description text
);

create table if not exists machine (
   id serial primary key,
   name varchar(255) not null,
   size_x integer not null default 0,
   size_y integer not null default 0,
   price bigint not null default 0
);

create table if not exists circuit_board (
    id serial primary key,
    name varchar(255) not null,
    sell_price bigint not null default 0
);

create table if not exists machine_recipe (
    id serial primary key,
    machine_id integer references machine on update cascade,
    circuit_board_id integer references circuit_board on update cascade,
    circuit_board_amount integer not null default 1,
    work_time bigint not null default 0,
    price bigint not null default 0
);

create table if not exists machine_recipe_tea (
    machine_recipe_id integer references machine_recipe on update cascade,
    tea_id integer references tea on update cascade,
    amount integer not null default 0,
    primary key (machine_recipe_id, tea_id)
);

create table if not exists machine_instance (
    id serial primary key,
    user_id integer references "user" on update cascade on delete cascade,
    machine_id integer references "machine" on update cascade,
    area_x integer not null,
    area_y integer not null,
    current_recipe_id integer references machine_recipe on update cascade,
    current_recipe_completion_time bigint
);

create table if not exists tea_instance (
    user_id integer references "user" on update cascade on delete cascade,
    tea_id integer references tea on update cascade,
    amount integer not null,
    primary key (user_id, tea_id)
);

create table if not exists circuit_board_instance
(
    user_id integer references "user" on update cascade on delete cascade,
    model_id integer references circuit_board on update cascade,
    amount integer not null
);

insert into tea (id, name, price, description) VALUES
(1, 'Черный чай', 10, ''),
(2, 'Зеленый чай', 30, ''),
(3, 'Красный чай', 60, ''),
(4, 'Чай со смородиной', 100, ''),
(5, 'Чай с шиповником', 130, ''),
(6, 'Чай с имбирем', 160, ''),
(7, 'Белый чай', 200, ''),
(8, 'Ройбуш', 400, ''),
(9, 'Чай с манго', 1050, ''),
(10, 'Чай с личи', 1200, ''),
(11, 'Чай с лавандой', 3800, ''),
(12, 'Чай с кипреем', 4400, '');

insert into machine (name, size_x, size_y, price) values
('Самодельная машина печатных плат', 100, 100, 200),
('Улучшенная самодельная машина печатных плат', 100, 120, 900),
('Промышленная машина печатных плат', 200, 200, 3000),
('Игровая машина печатных плат с красивой подсветкой', 250, 220, 8000),
('Машина печатных плат с искусственным интеллектом', 300, 240, 20000),
('Квантовая машина печатных плат', 320, 320, 70000);

insert into circuit_board (id, name, sell_price) values
(1, 'Однослойная печатная плата', 30),
(2, 'Двухслойная печатная плата', 80),
(3, 'Лакированная печатная плата', 120),
(4, 'Восьмислойная печатная плата', 340),
(5, 'Печатная плата с алюминиевым теплоотводом', 480),
(6, 'Керамическая высокотемпературная печатная плата', 750),
(7, 'Гибкая печатная плата из каптона', 1170),
(8, 'Жидкая печатная плата с искусственным интеллектом', 3100),
(9, 'Квантовая печатная плата с интегрированной рекламой Яндекс.Такси', 8990);

insert into machine_recipe (machine_id, circuit_board_id, work_time)
values
(1, 1, 30), (1, 2, 4 * 60),
(2, 3, 7 * 60), (2, 4, 23 * 60),
(3, 5, 31 * 60), (3, 6, 46 * 60),
(4, 7, 61 * 60),
(5, 8, 74 * 60),
(6, 9, 92 * 60);

insert into machine_recipe_tea (machine_recipe_id, tea_id, amount)
values
(1, 1, 2),
(2, 1, 1),
(2, 2, 2),
(3, 1, 1),
(3, 2, 1),
(3, 3, 1),
(4, 5, 2),
(4, 4, 1),
(4, 1, 2),
(5, 8, 1),
(5, 7, 1),
(6, 6, 3),
(6, 5, 1),
(7, 8, 2),
(7, 7, 1),
(7, 2, 1),
(8, 9, 1),
(8, 10, 1),
(8, 3, 3),
(9, 11, 1),
(9, 12, 1);


-- create or replace function update_user_level (_id integer, _login varchar, _level bigint)
-- returns void as
-- $$
--     begin
--         update "user" set level = _level where id = _id and login = _login;
--     end
-- $$ language plpgsql;

create or replace function delete_machine_instance (_user_id integer, _machine_id integer,
                                                      _x integer, _y integer)
returns void as
$$
    begin
        delete from machine_instance where user_id = _user_id and machine_id = _machine_id and area_x = _x and area_y = _y;
    end
$$ language plpgsql;

create or replace function update_machine_instance_coordinates (_machine_id integer, _x integer, _y integer)
returns int as
$$
    begin
        update machine_instance set area_x = _x, area_y = _y where id = _machine_id;
        return 0;
    end
$$ language plpgsql;

create or replace function _trigger_delete_user_tea_instance() returns trigger as $$
begin
    if new.amount = 0 then
        delete from tea_instance where user_id = new.user_id and tea_id = new.tea_id;
        return NULL; -- do not execute other triggers
    end if;
    return new;
end;
$$ language plpgSQL;

create trigger delete_user_tea_instance after update on tea_instance
    for each row execute procedure _trigger_delete_user_tea_instance();

create or replace function buy_tea (_user_id integer, _tea_id integer, _amount integer)
returns boolean as
$$
    declare
        money_amount integer := 0;
        tea_price bigint := 0;
    begin
        if _amount < 0 then
            return false;
        end if;
        select money from "user" where id = _user_id into money_amount;
        select price from tea where id = _tea_id into tea_price;
        if (money_amount - tea_price * _amount >= 0) then
            if exists(select * from tea_instance where user_id = _user_id and tea_id = _tea_id) then
                update tea_instance set amount = amount - _amount where user_id = _user_id and tea_id = _tea_id;
            else
                insert into tea_instance (user_id, tea_id, amount) values (_user_id, _tea_id, _amount);
            end if;
            update "user" set money = money_amount - tea_price * _amount where id = _user_id;
            return true;
        else
            return false;
        end if;
    end
$$ language plpgsql;

create or replace function _trigger_delete_user_circuit_board_instance() returns trigger as $$
begin
    if new.amount = 0 then
        delete from circuit_board_instance where user_id = new.user_id and model_id = new.model_id;
        return NULL; -- do not execute other triggers
    end if;
    return new;
end;
$$ language plpgSQL;

create trigger delete_user_circuit_board_instance after update on circuit_board_instance
    for each row execute procedure _trigger_delete_user_circuit_board_instance();

create or replace function insert_playing_field_item (_user_id integer, _machine_id integer,
                                                      _x integer, _y integer)
returns void as
$$
    begin
        -- проверка что ничего ни с чем не пересекается (в spring)
        insert into machine_instance (user_id, machine_id, area_x, area_y) values (_user_id, _machine_id, _x, _y);
    end
$$ language plpgsql;

create or replace function check_coordinates(_user_id integer, left_x integer, top_y integer, _w integer, _h integer)
returns boolean as
$$
    declare
        i integer := 0;
        right_x integer := left_x + _w;
        bottom_y integer := top_y + _h;
        machines_count integer := 0;
        it machine_instance%ROWTYPE;
        cur_model_width integer := 0;
        cur_model_height integer := 0;
    begin
        if !(left_x >= 0 or right_x < 1000 or top_y >= 0 or bottom_y < 1000) then
            return false;
        end if;
        select count(*) from circuit_board_instance where user_id = _user_id into machines_count;
        if (machines_count = 0) then return true;
        else
            for i in 1 .. machines_count loop
                select * into it from machine_instance where user_id = _user_id limit 1 offset i;
                select size_x from machine where id = it.id into cur_model_width;
                select size_y from machine where id = it.id into cur_model_height;
                if (((it.area_x >= left_x and it.area_x <= right_x) or (left_x >= it.area_x and left_x <= it.area_x + cur_model_width))
                       and
                   ((it.area_y >= top_y and it.area_y <= bottom_y) or (top_y >= it.area_y and top_y <= it.area_y + cur_model_height)))
                then
                    return false;
                else continue;
                end if;
            end loop;
        return true;
        end if;
    end;
$$ language plpgsql;

create or replace function buy_machine (_user_id integer, _machine_id integer,
                                        _x integer, _y integer)
returns integer as
$$
    declare
        money_amount integer := 0;
        machine_price bigint := 0;
        instance_id integer := 0;
        check_coords boolean := false;
    begin
        select money from "user" where id = _user_id into money_amount;
        select price from machine where id = _machine_id into machine_price;
        perform check_coordinates(_user_id, _machine_id, _x, _y) into check_coords;
        if (!check_coords) then return -1;
        else
            if (money_amount - machine_price >= 0) then
                perform insert_playing_field_item(_user_id, _machine_id, _x, _y);
                update "user" set money = money_amount - machine_price where id = _user_id;
                select id from machine_instance where user_id = _user_id and machine_id = _machine_id and
                                                      area_x = _x and area_y = _y into instance_id;
                return instance_id;
            else
                return -1;
            end if;
        end if;
    end
$$ language plpgsql;

create or replace function produce_circuit_board (_instance_id integer, _recipe_id integer) returns int as
$$
    declare
        _recipe_time integer := 0;
    begin
        select work_time from machine_recipe where id = _recipe_id into _recipe_time;
        update machine_instance set current_recipe_id = _recipe_id where id = _instance_id;
        update machine_instance set current_recipe_completion_time = now() + _recipe_time where id = _instance_id;
        return 0;
    end;
$$ language plpgsql;


create or replace function sell_user_circuit_board_instance (_user_id integer, _model_id integer,
                                        _amount integer)
returns void as
$$
    declare
        money_amount integer := 0;
        model_price bigint := 0;
    begin
        select money from "user" where id = _user_id into money_amount;
        select sell_price from circuit_board where id = _model_id into model_price;
        update circuit_board_instance set amount = amount - _amount where user_id = _user_id and model_id = _model_id;
        update "user" set money = money + _amount * model_price where id = _user_id;
    end
$$ language plpgsql;