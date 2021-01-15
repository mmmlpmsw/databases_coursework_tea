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
); -- удалять строку, когда amount = 0

create table if not exists circuit_board_instance
(
    user_id integer references "user" on update cascade on delete cascade,
    model_id integer references circuit_board on update cascade,
    amount integer not null
); -- удалять строку, когда amount = 0


create or replace function insert_tea (_name varchar, _price integer, _description text)
returns void as
$$
    begin
        insert into tea (name, price, description) VALUES (_name, _price, _description);
    end;
$$ language plpgsql;

select insert_tea('Черный чай', 10, '');
select insert_tea('Зеленый чай', 20, '');
select insert_tea('Красный чай', 30, '');
select insert_tea('Персиковый чай', 50, '');
select insert_tea('Ананасовый чай', 60, '');
select insert_tea('Чай со смородиной', 100, '');
select insert_tea('Чай с шиповником', 130, '');
select insert_tea('Чай с имбирем', 160, '');
select insert_tea('Белый чай', 200, '');
select insert_tea('Желтый чай', 300, '');
select insert_tea('Ройбуш', 400, '');
select insert_tea('Чай с манго', 1050, '');
select insert_tea('Чай с личи', 1200, '');
select insert_tea('Чай с черникой', 1000, '');
select insert_tea('Чай с лавандой', 3800, '');
select insert_tea('Чай с ромашкой', 2400, '');
select insert_tea('Чай с кипреем', 4400, '');

create or replace function insert_machine (_name varchar, _width integer, _height integer, _price integer)
returns void as
$$
    begin
        insert into machine (name, size_x, size_y, price) values (_name, _width, _height, _price);
    end;
$$ language plpgsql;

select insert_machine('Machine 1', 30, 30, 100);
select insert_machine('Machine 2', 50, 70, 800);
select insert_machine('Machine 3', 60, 80, 3000);
select insert_machine('Machine 4', 80, 100, 8000);
select insert_machine('Machine 5', 100, 100, 20000);
select insert_machine('Machine 6', 120, 140, 80000);

create or replace function insert_circuit_board (_name varchar, _price integer)
returns void as
$$
    begin
        insert into circuit_board (name, sell_price) values (_name, _price);
    end;
$$ language plpgsql;

select insert_circuit_board('Лазерная указка', 20);
select insert_circuit_board('Коммутирующие приборы',30);
select insert_circuit_board('Печатающие головки',60);

select insert_circuit_board('Настольный вентилятор', 90);
select insert_circuit_board('Пульт', 100);
select insert_circuit_board('Калькулятор', 120);

select insert_circuit_board('Машинка на радиоупр.', 230);
select insert_circuit_board('Микроконтроллер', 420);
select insert_circuit_board('DVD-привод', 660);

select insert_circuit_board('Панель', 940);
select insert_circuit_board('Системы контроля', 800);
select insert_circuit_board('Вариометр', 4);

select insert_circuit_board('Холодильник', 3100);
select insert_circuit_board('Утюг', 1200);
select insert_circuit_board('Робот-пылесос', 5500);

select insert_circuit_board('Одноплатный комп.', 7300);
select insert_circuit_board('Принтер', 6800);
select insert_circuit_board('Проектор', 9800);

create or replace function insert_recipe (_machine_id integer, _circuit_board_id integer, _work_time integer)
returns void as
$$
    begin
        insert into machine_recipe (machine_id, circuit_board_id, work_time)
        values (_machine_id, _circuit_board_id, _work_time);
    end;
$$ language plpgsql;

select insert_recipe(1, 1, 300);
select insert_recipe(1,2, 480);
select insert_recipe(1,3, 600);

select insert_recipe(2,4, 720);
select insert_recipe(2,5, 900);
select insert_recipe(2,6, 1380);

select insert_recipe(3,7, 1920);
select insert_recipe(3,8, 3060);
select insert_recipe(3,9, 3240);

select insert_recipe(4,10, 67 * 60);
select insert_recipe(4,11, 61 * 60);
select insert_recipe(4,12, 2520);

select insert_recipe(5, 13, 75 * 60);
select insert_recipe(5,14, 62 * 60);
select insert_recipe(5,15, 84 * 60);

select insert_recipe(6,16, 102 * 60);
select insert_recipe(6,17, 90 * 60);
select insert_recipe(6,18, 116 * 60);

create or replace function insert_recipe_tea (_machine_recipe_id integer, _tea_id integer, _amount integer)
returns void as
$$
    begin
        insert into machine_recipe_tea (machine_recipe_id, tea_id, amount)
        values (_machine_recipe_id, _tea_id, _amount);
    end;
$$ language plpgsql;

select insert_recipe_tea(1, 1, 1);
select insert_recipe_tea(2, 1, 2);
select insert_recipe_tea(3, 1, 1);
select insert_recipe_tea(3, 2, 2);
select insert_recipe_tea(4, 5, 1);
select insert_recipe_tea(4, 2, 1);
select insert_recipe_tea(5, 4, 1);
select insert_recipe_tea(5, 3, 2);
select insert_recipe_tea(6, 3, 1);
select insert_recipe_tea(6, 1, 2);
select insert_recipe_tea(6, 2, 2);
select insert_recipe_tea(7, 6, 1);
select insert_recipe_tea(7, 2, 2);
select insert_recipe_tea(7, 4, 1);
select insert_recipe_tea(8, 7, 2);
select insert_recipe_tea(8, 6, 1);
select insert_recipe_tea(8, 1, 2);
select insert_recipe_tea(9, 8, 3);
select insert_recipe_tea(9, 7, 1);
select insert_recipe_tea(10, 11, 1);
select insert_recipe_tea(10, 9, 2);
select insert_recipe_tea(11, 11, 1);
select insert_recipe_tea(11, 10, 1);
select insert_recipe_tea(11, 4, 1);
select insert_recipe_tea(12, 3, 4);
select insert_recipe_tea(12, 10, 2);
select insert_recipe_tea(13, 9, 2);
select insert_recipe_tea(13, 13, 2);
select insert_recipe_tea(14, 7, 1);
select insert_recipe_tea(14, 14, 1);
select insert_recipe_tea(15, 13, 3);
select insert_recipe_tea(15, 12, 1);
select insert_recipe_tea(15, 8, 4);
select insert_recipe_tea(16, 15, 1);
select insert_recipe_tea(16, 16, 1);
select insert_recipe_tea(16, 8, 4);
select insert_recipe_tea(17, 16, 2);
select insert_recipe_tea(17, 11, 3);
select insert_recipe_tea(18, 17, 2);
select insert_recipe_tea(18, 10, 2);

create or replace function insert_user (_login varchar, _name varchar,
                                        _password_hash varchar, _money bigint, _level integer)
returns void as
$$
    begin
        insert into "user" (login, name, password_hash, money/*, level*/) values (_login, _name, _password_hash, _money/*, _level*/);
    end
$$ language plpgsql;

create or replace function update_user_money (_id integer, _login varchar, _money bigint)
returns void as
$$
    begin
        update "user" set money = _money where id = _id and login = _login;
    end
$$ language plpgsql;

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

create or replace function update_machine_instance_coordinates (_user_id integer, _machine_id integer,
                                                      _x integer, _y integer, _x_old integer, _y_old integer)
returns void as
$$
    begin
        update machine_instance set area_x = _x where user_id = _user_id and machine_id = _machine_id and area_x = _x_old and area_y = _y_old;
        update machine_instance set area_y = _y where user_id = _user_id and machine_id = _machine_id and area_x = _x_old and area_y = _y_old;
    end
$$ language plpgsql;

create or replace function insert_user_tea_instance (_user_id integer, _tea_id integer, _amount integer)
returns void as
$$
    begin
        insert into tea_instance (user_id, tea_id, amount) values (_user_id, _tea_id, _amount);
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
        select money from "user" where id = _user_id into money_amount;
        select price from tea where id = _tea_id into tea_price;
        if (money_amount - tea_price * _amount >= 0) then
            select insert_user_tea_instance(_user_id, _tea_id, _amount);
            update "user" set money = money_amount - tea_price * _amount where id = _user_id;
            return true;
        else
            return false;
        end if;
    end
$$ language plpgsql;

create or replace function insert_circuit_board_instance (_user_id integer, _model_id integer, _amount integer)
returns void as
$$
    begin
        insert into circuit_board_instance(user_id, model_id, amount) values (_user_id, _model_id, _amount);
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

create or replace function buy_machine (_user_id integer, _machine_id integer,
                                        _x integer, _y integer)
returns boolean as
$$
    declare
        money_amount integer := 0;
        machine_price bigint := 0;
    begin
        select money from "user" where id = _user_id into money_amount;
        select price from machine where id = _machine_id into machine_price;
        if (money_amount - machine_price >= 0) then
            select insert_playing_field_item(_user_id, _machine_id, _x, _y);
            update "user" set money = money_amount - machine_price where id = _user_id;
            return true;
        else
            return false;
        end if;
    end
$$ language plpgsql;


create table if not exists circuit_board_instance
(
    user_id integer references "user" on update cascade on delete cascade,
    model_id integer references circuit_board on update cascade,
    amount integer not null
);

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