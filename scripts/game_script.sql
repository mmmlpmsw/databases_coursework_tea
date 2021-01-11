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
    money bigint not null default 0,
    level int not null default 1
);

create table if not exists tea (
    id serial primary key,
    name varchar(255) not null,
    price integer not null default 0,
    description text
);

create table if not exists machine (
   id serial primary key,
   name varchar(255) not null,
   width integer not null default 0,
   height integer not null default 0,
   price integer not null default 0
);

create table if not exists pcb_model (
    id serial primary key,
    name varchar(255) not null,
    machine_id integer references machine on update cascade, -- на удаление - ничего (зачем удалять машину?)
    price integer not null default 0,
    production_time_sec bigint not null default 0
);

create table if not exists recipe (
    pcb_model_id integer references pcb_model on update cascade,
    tea_id integer references tea on update cascade,
    amount integer not null
);

create table if not exists playing_field_state (
    user_id integer references "user" on update cascade on delete cascade,
    machine_id integer references "machine" on update cascade,
    x integer not null,
    y integer not null,
    primary key (user_id, machine_id, x, y)
);

create table if not exists user_tea (
    user_id integer references "user" on update cascade on delete cascade,
    tea_id integer references tea on update cascade,
    amount integer not null
); -- удалять строку, когда amount = 0

create table if not exists equipment
(
    user_id integer references "user" on update cascade on delete cascade,
    pcb_model_id integer references pcb_model on update cascade,
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
        insert into machine (name, width, height, price) values (_name, _width, _height, _price);
    end;
$$ language plpgsql;

select insert_machine('Machine 1', 30, 30, 100);
select insert_machine('Machine 2', 50, 70, 800);
select insert_machine('Machine 3', 60, 80, 3000);
select insert_machine('Machine 4', 80, 100, 8000);
select insert_machine('Machine 5', 100, 100, 20000);
select insert_machine('Machine 6', 120, 140, 80000);

create or replace function insert_pcb_model (_name varchar, _machine_id integer, _price integer, _production_time_sec bigint)
returns void as
$$
    begin
        insert into pcb_model (name, machine_id, price, production_time_sec) values (_name, _machine_id, _price, _production_time_sec);
    end;
$$ language plpgsql;


select insert_pcb_model('Лазерная указка', 1, 20, 300);
select insert_pcb_model('Коммутирующие приборы',1, 30, 480);
select insert_pcb_model('Печатающие головки',1, 60, 600);

select insert_pcb_model('Настольный вентилятор',2, 90, 720);
select insert_pcb_model('Пульт',2, 100, 900);
select insert_pcb_model('Калькулятор',2, 120, 1380);

select insert_pcb_model('Машинка на радиоупр.',3, 230, 1920);
select insert_pcb_model('Микроконтроллер',3, 420, 3060);
select insert_pcb_model('DVD-привод',3, 660, 3240);

select insert_pcb_model('Панель',4, 940, 67 * 60);
select insert_pcb_model('Системы контроля',4, 800, 61 * 60);
select insert_pcb_model('Вариометр',4, 730, 2520);

select insert_pcb_model('Холодильник',5, 3100, 75 * 60);
select insert_pcb_model('Утюг',5, 1200, 62 * 60);
select insert_pcb_model('Робот-пылесос',5, 5500, 84 * 60);

select insert_pcb_model('Одноплатный комп.',6, 7300, 102 * 60);
select insert_pcb_model('Принтер',6, 6800, 90 * 60);
select insert_pcb_model('Проектор',6, 9800, 116 * 60);

create or replace function insert_recipe (_pcb_model_id integer, _tea_id integer, _amount integer)
returns void as
$$
    begin
        insert into recipe (pcb_model_id, tea_id, amount) values (_pcb_model_id, _tea_id, _amount);
    end;
$$ language plpgsql;

select insert_recipe(1, 1, 1);
select insert_recipe(2, 1, 2);
select insert_recipe(3, 1, 1);
select insert_recipe(3, 2, 2);
select insert_recipe(4, 5, 1);
select insert_recipe(4, 2, 1);
select insert_recipe(5, 4, 1);
select insert_recipe(5, 3, 2);
select insert_recipe(6, 3, 1);
select insert_recipe(6, 1, 2);
select insert_recipe(6, 2, 2);
select insert_recipe(7, 6, 1);
select insert_recipe(7, 2, 2);
select insert_recipe(7, 4, 1);
select insert_recipe(8, 7, 2);
select insert_recipe(8, 6, 1);
select insert_recipe(8, 1, 2);
select insert_recipe(9, 8, 3);
select insert_recipe(9, 7, 1);
select insert_recipe(10, 11, 1);
select insert_recipe(10, 9, 2);
select insert_recipe(11, 11, 1);
select insert_recipe(11, 10, 1);
select insert_recipe(11, 4, 1);
select insert_recipe(12, 3, 4);
select insert_recipe(12, 10, 2);
select insert_recipe(13, 9, 2);
select insert_recipe(13, 13, 2);
select insert_recipe(14, 7, 1);
select insert_recipe(14, 14, 1);
select insert_recipe(15, 13, 3);
select insert_recipe(15, 12, 1);
select insert_recipe(15, 8, 4);
select insert_recipe(16, 15, 1);
select insert_recipe(16, 16, 1);
select insert_recipe(16, 8, 4);
select insert_recipe(17, 16, 2);
select insert_recipe(17, 11, 3);
select insert_recipe(18, 17, 2);
select insert_recipe(18, 10, 2);

create or replace function insert_user (_login varchar, _name varchar,
                                        _password_hash varchar, _money bigint, _level integer)
returns void as
$$
    begin
        insert into "user" (login, name, password_hash, money, level) values (_login, _name, _password_hash, _money, _level);
    end
$$ language plpgsql;

create or replace function update_user_money (_id integer, _login varchar, _money bigint)
returns void as
$$
    begin
        update "user" set money = _money where id = _id and login = _login;
    end
$$ language plpgsql;

create or replace function update_user_level (_id integer, _login varchar, _level bigint)
returns void as
$$
    begin
        update "user" set level = _level where id = _id and login = _login;
    end
$$ language plpgsql;

create or replace function delete_playing_field_item (_user_id integer, _machine_id integer,
                                                      _x integer, _y integer)
returns void as
$$
    begin
        delete from playing_field_state where user_id = _user_id and machine_id = _machine_id and x = _x and y = _y;
    end
$$ language plpgsql;

create or replace function update_playing_field_item_coordinates (_user_id integer, _machine_id integer,
                                                      _x integer, _y integer, _x_old integer, _y_old integer)
returns void as
$$
    begin
        update playing_field_state set x = _x where user_id = _user_id and machine_id = _machine_id and x = _x_old and y = _y_old;
        update playing_field_state set y = _y where user_id = _user_id and machine_id = _machine_id and x = _x_old and y = _y_old;
    end
$$ language plpgsql;

create or replace function insert_user_tea (_user_id integer, _tea_id integer, _amount integer)
returns void as
$$
    begin
        insert into user_tea (user_id, tea_id, amount) values (_user_id, _tea_id, _amount);
    end
$$ language plpgsql;
-- todo trigger удалять строку, когда amount = 0

create or replace function buy_tea (_user_id integer, _tea_id integer, _amount integer)
returns boolean as
$$
    declare
        money_amount integer := 0;
        tea_price integer := 0;
    begin
        select money from "user" where id = _user_id into money_amount;
        select price from tea where id = _tea_id into tea_price;
        if (money_amount - tea_price * _amount >= 0) then
            select insert_user_tea(_user_id, _tea_id, _amount);
            update "user" set money = money_amount - tea_price * _amount where id = _user_id;
            return true;
        else
            return false;
        end if;
    end
$$ language plpgsql;

create or replace function insert_equipment (_user_id integer, _pcb_model_id integer, _amount integer)
returns void as
$$
    begin
        insert into equipment(user_id, pcb_model_id, amount) values (_user_id, _pcb_model_id, _amount);
    end
$$ language plpgsql;
-- todo trigger удалять строку, когда amount = 0

create or replace function insert_playing_field_item (_user_id integer, _machine_id integer,
                                                      _x integer, _y integer)
returns void as
$$
    begin
        -- проверка что ничего ни с чем не пересекается (в spring)
        insert into playing_field_state (user_id, machine_id, x, y) values (_user_id, _machine_id, _x, _y);
    end
$$ language plpgsql;

create or replace function buy_machine (_user_id integer, _machine_id integer,
                                                      _x integer, _y integer)
returns boolean as
$$
    declare
        money_amount integer := 0;
        machine_price integer := 0;
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