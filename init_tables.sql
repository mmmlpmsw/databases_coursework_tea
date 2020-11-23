/**
  * удаление всех таблиц и типов, создание необходимых типов данных
 */
drop table if exists store, product, store_item, tea_composition, store_item, tea, cupboard_item, composition_item,
    circuit_board_model, circuit_board_machine, circuit_board_machine_param_item, customer, address, "order",
    circuit_board, order_item, delivery_truck, factory_employee, tea_cupboard;
drop table if exists employee_machine_xref cascade;
drop type if exists circuit_board_machine_state cascade;
drop type if exists customer_type cascade;
CREATE TYPE circuit_board_machine_state AS ENUM ('ok', 'broken', 'decommissioned');
CREATE TYPE customer_type AS ENUM ('legal_entity', 'individual');

/**
  * создание всех таблиц
  * триггеры:
  * 1) при создании/удалении строки в tea добавляется соотв. строка в product
  * (add_tea_to_products, delete_tea_from_products)
  * 2) при создании/удалении строки в tea_composition добавляется соотв. строка в product
  * (add_tea_composition_to_products, delete_tea_composition_from_products())
  *
  *-----------------------------------------------------------------------------------------
  *
  * to be done: (желательно по мере выполнения переносить их из 'to be done' в готовые)
  * --todo 3) в чайной композиции обязательно должен быть хотя бы 1 вид чая
  * --todo 4) При insert into circuit_board, у производящей машины увеличивается work_hrs
  * (в зависимости от его параметров), с вероятностью 0.02*work_hrs
  * машина может сломаться.
  * --todo 5) Если в store_item кончается товар (amount = 0), строка с ним удалится
 */

create table if not exists store (
    id serial primary key,
    name varchar(255) not null
);

create table if not exists product (
    id serial primary key,
    name varchar(255) not null
);

create table if not exists factory_employee (
    id serial primary key,
    fname varchar(255) not null,
    mname varchar(255),
    lname varchar(255) not null
);

create table if not exists tea (
    super_id serial primary key references product on delete cascade on update cascade,
    type varchar(128) not null,
    created date not null check (created <= now())
);

CREATE OR REPLACE FUNCTION add_tea_to_products() RETURNS trigger AS
$$
DECLARE
    _id integer := 0;
BEGIN
    insert into product(name) values ('Tea') returning id into _id;
    NEW.super_id := _id;
    return new;
END;
$$ LANGUAGE plpgSQL;

CREATE TRIGGER add_tea_to_products
    before INSERT ON tea
    FOR EACH row
    EXECUTE PROCEDURE add_tea_to_products();

CREATE OR REPLACE FUNCTION delete_product() RETURNS trigger AS
$$
BEGIN
    delete from product where id = old.super_id;
    return old;
END;
$$ LANGUAGE plpgSQL;

CREATE TRIGGER delete_tea_from_products
    after DELETE ON tea
    FOR EACH row
    EXECUTE PROCEDURE delete_product(super_id);

create table if not exists tea_cupboard (
    id serial primary key,
    owner_id int references factory_employee on delete cascade on update cascade,
    color int check ( color > 0 and color < cast(x'FFFFFF' as int) ),
    capacity real check ( capacity > 0 )
);

create table if not exists circuit_board_model (
    id varchar(128),
    version varchar(128),
    element_gap real not null check ( element_gap > 0 ),
    hole_diameter real not null check ( hole_diameter > 0 ),
    stiffness real not null,
    thermal_expansion_coef real not null,
    primary key (id, version)
);

create table if not exists circuit_board_machine (
    id serial primary key,
    assembly_date date not null check ( assembly_date <= now() ) default now(),
    work_hrs real not null check ( work_hrs >= 0 ) default 0,
    area real not null check ( area > 0 ),
    state circuit_board_machine_state not null
);

create table if not exists employee_machine_xref (
    employee_id integer references factory_employee(id) on update cascade on delete cascade,
    machine_id integer references circuit_board_machine(id) on update cascade on delete cascade,
    primary key (employee_id, machine_id)
);

create table if not exists circuit_board_machine_param_item (
    machine_id int references circuit_board_machine(id) on update cascade on delete cascade,
    board_model_id varchar(128),
    board_model_version varchar(128),
    speed real not null check ( speed > 0 ),
    primary key (machine_id, board_model_id, board_model_version),
    foreign key (board_model_id, board_model_version) references circuit_board_model(id, version) on update cascade on delete cascade
);

create table if not exists customer (
    id serial primary key,
    type customer_type not null,
    fname varchar(255) not null,
    mname varchar(255),
    lname varchar(255) not null,
    email varchar(255) check (email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'),
    phone bigint,
    ITIN bigint check ( ITIN >= 0 and ITIN <= 9999999999) default null,
    company_name varchar(255),
    check ( email is not null or phone is not null )
);

create table if not exists address (
    id serial primary key,
    owner_id int not null references customer on delete cascade on update cascade,
    country varchar(255) not null,
    city varchar(255) not null,
    street varchar(255) not null,
    building int not null,
    comment text
);

create table if not exists tea_composition (
    super_id serial primary key references product on delete cascade on update cascade,
    created date not null,
    name varchar not null,
    description text
-- todo convert to trigger
--     check (
--         (
--             select count(ci.product_id) from composition_item ci
--             left join tea t on t.super_id = ci.product_id
--             where ci.product_id = t.super_id
--         ) > 0
--     )
);

CREATE OR REPLACE FUNCTION add_tea_composition_to_products() RETURNS trigger AS
$$
DECLARE
    _id integer := 0;
BEGIN
    insert into product(name) values ('Tea Composition') returning id into _id;
    NEW.super_id := _id;
    return new;
END;
$$ LANGUAGE plpgSQL;

CREATE TRIGGER add_tea_composition_to_products
    before INSERT ON tea_composition
    FOR EACH row
    EXECUTE PROCEDURE add_tea_composition_to_products();

CREATE TRIGGER delete_tea_composition_from_products
    after DELETE ON tea_composition
    FOR EACH row
    EXECUTE PROCEDURE delete_product(super_id);

create table if not exists store_item (
    store_id int references store on delete cascade on update cascade,
    product_id int references product on delete cascade on update cascade,
    amount real not null,
    primary key (store_id, product_id)
);

create table if not exists cupboard_item (
    product_id int references tea on delete cascade on update cascade,
    cupboard_id int references tea_cupboard on delete cascade on update cascade,
    amount real not null check ( amount > 0 ),
    primary key (product_id, cupboard_id)
);

create table if not exists composition_item (
    composition_id int references tea_composition on delete cascade on update cascade,
    product_id int references product on delete restrict on update cascade,
    amount_percent real not null check ( amount_percent between 0 and 100 ),
    primary key (composition_id, product_id)
);

create table if not exists "order" (
    id serial primary key,
    customer_id int not null check(customer_id > 0) references customer on delete restrict on update cascade,
    address_id int not null check(address_id > 0) references address on delete restrict on update restrict, -- if customer delete his address, we could lose existing order
    accepted timestamp,
    fulfilled timestamp,
    delivered timestamp,
    comment text
);

create table if not exists circuit_board (
    id serial primary key,
    model_id varchar(128) not null,
    model_version varchar(128) not null,
    order_id int not null references "order" on update cascade on delete restrict,
    assembled_by int not null references circuit_board_machine on update cascade on delete restrict,
    price real not null check ( price > 0 ),
    foreign key (model_id, model_version) references circuit_board_model(id, version) on update cascade on delete restrict
);

create table if not exists order_item (
    order_id int not null references "order" on update cascade on delete cascade,
    board_model_id varchar(128) not null,
    board_model_version varchar(128) not null,
    amount int not null,
    foreign key (board_model_id, board_model_version) references circuit_board_model(id, version) on update cascade on delete cascade
);

create table if not exists delivery_truck (
    id serial primary key,
    order_id int default null references "order" on update cascade on delete set default,
    capacity int not null check(capacity > 0),
    delivery_by timestamp default null,
    check ( order_id IS NOT NULL AND delivery_by IS NOT NULL OR order_id IS NULL AND delivery_by IS NULL)
);