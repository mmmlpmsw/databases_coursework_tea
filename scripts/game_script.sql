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

insert into tea (name, price, description) VALUES
('Черный чай', 10, ''),
('Зеленый чай', 20, ''),
('Красный чай', 30, ''),
('Персиковый чай', 50, ''),
('Ананасовый чай', 60, ''),
('Чай со смородиной', 100, ''),
('Чай с шиповником', 130, ''),
('Чай с имбирем', 160, ''),
('Белый чай', 200, ''),
('Желтый чай', 300, ''),
('Ройбуш', 400, ''),
('Чай с манго', 1050, ''),
('Чай с личи', 1200, ''),
('Чай с черникой', 1000, ''),
('Чай с лавандой', 3800, ''),
('Чай с ромашкой', 2400, ''),
('Чай с кипреем', 4400, '');

create or replace function insert_machine (_name varchar, _width integer, _height integer, _price integer)
returns void as
$$
    begin
        insert into machine (name, size_x, size_y, price) values (_name, _width, _height, _price);
    end;
$$ language plpgsql;

insert into machine (name, size_x, size_y, price) values
('Machine 1', 30, 30, 100),
('Machine 2', 50, 70, 800),
('Machine 3', 60, 80, 3000),
('Machine 4', 80, 100, 8000),
('Machine 5', 100, 100, 20000),
('Machine 6', 120, 140, 80000);

create or replace function insert_circuit_board (_name varchar, _price integer)
returns void as
$$
    begin
        insert into circuit_board (name, sell_price) values (_name, _price);
    end;
$$ language plpgsql;

insert into circuit_board (name, sell_price) values
('Лазерная указка', 20),
('Коммутирующие приборы',30),
('Печатающие головки',60),

('Настольный вентилятор', 90),
('Пульт', 100),
('Калькулятор', 120),

('Машинка на радиоупр.', 230),
('Микроконтроллер', 420),
('DVD-привод', 660),

('Панель', 940),
('Системы контроля', 800),
('Вариометр', 4),

('Холодильник', 3100),
('Утюг', 1200),
('Робот-пылесос', 5500),

('Одноплатный комп.', 7300),
('Принтер', 6800),
('Проектор', 9800);

create or replace function insert_recipe (_machine_id integer, _circuit_board_id integer, _work_time integer)
returns void as
$$
    begin
        insert into machine_recipe (machine_id, circuit_board_id, work_time)
        values (_machine_id, _circuit_board_id, _work_time);
    end;
$$ language plpgsql;

insert into machine_recipe (machine_id, circuit_board_id, work_time)
values
(1, 1, 300), (1,2, 480), (1,3, 600),
(2,4, 720), (2,5, 900), (2,6, 1380),
(3,7, 1920), (3,8, 3060), (3,9, 3240),
(4,10, 67 * 60), (4,11, 61 * 60), (4,12, 2520),
(5, 13, 75 * 60), (5,14, 62 * 60), (5,15, 84 * 60),
(6,16, 102 * 60), (6,17, 90 * 60), (6,18, 116 * 60);

create or replace function insert_recipe_tea (_machine_recipe_id integer, _tea_id integer, _amount integer)
returns void as
$$
    begin
        insert into machine_recipe_tea (machine_recipe_id, tea_id, amount)
        values (_machine_recipe_id, _tea_id, _amount);
    end;
$$ language plpgsql;

insert into machine_recipe_tea (machine_recipe_id, tea_id, amount)
values
(1, 1, 1),
(2, 1, 2),
(3, 1, 1),
(3, 2, 2),
(4, 5, 1),
(4, 2, 1),
(5, 4, 1),
(5, 3, 2),
(6, 3, 1),
(6, 1, 2),
(6, 2, 2),
(7, 6, 1),
(7, 2, 2),
(7, 4, 1),
(8, 7, 2),
(8, 6, 1),
(8, 1, 2),
(9, 8, 3),
(9, 7, 1),
(10, 11, 1),
(10, 9, 2),
(11, 11, 1),
(11, 10, 1),
(11, 4, 1),
(12, 3, 4),
(12, 10, 2),
(13, 9, 2),
(13, 13, 2),
(14, 7, 1),
(14, 14, 1),
(15, 13, 3),
(15, 12, 1),
(15, 8, 4),
(16, 15, 1),
(16, 16, 1),
(16, 8, 4),
(17, 16, 2),
(17, 11, 3),
(18, 17, 2),
(18, 10, 2);

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