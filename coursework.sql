drop table if exists store, product, store_item, tea_composition, store_item, tea, cupboard_item, composition_item,
    circuit_board_model, circuit_board_machine, circuit_board_machine_param_item, customer, address, "order",
    circuit_board, order_item, delivery_truck, factory_employee, tea_cupboard;
drop type if exists curcuit_board_machine_state, customer_type;
CREATE TYPE curcuit_board_machine_state AS ENUM ('ok', 'broken', 'decommissioned');
CREATE TYPE customer_type AS ENUM ('legal_entity', 'individual');

create table if not exists store (
    id serial PRIMARY KEY NOT NULL,
    name varchar(255) NOT NULL
);

create table if not exists product (
    id serial PRIMARY KEY NOT NULL,
    name varchar(255) NOT NULL
);

create table if not exists tea_composition (
    super_id serial PRIMARY KEY NOT NULL REFERENCES product,
    name varchar(255) NOT NULL
);

create table if not exists store_item (
    store_id int NOT NULL REFERENCES store /*todo delete update*/,
    product_id int NOT NULL REFERENCES product /*todo delete update*/,
    amount real NOT NULL
);

create table if not exists tea (
    super_id serial PRIMARY KEY NOT NULL REFERENCES product,
    type varchar(128) NOT NULL,
    created date NOT NULL
);

create table if not exists factory_employee (
    id serial PRIMARY KEY NOT NULL,
    fname varchar(255) NOT NULL,
    mname varchar(255),
    lname varchar(255) NOT NULL
);

create table if not exists tea_cupboard (
    id serial PRIMARY KEY NOT NULL,
    owner_id int NOT NULL REFERENCES factory_employee /*todo delete update*/
);

create table if not exists cupboard_item (
    product_id int NOT NULL REFERENCES tea /*todo delete update*/,
    cupboard_id int NOT NULL REFERENCES tea_cupboard /*todo delete update*/,
    amount real NOT NULL
);

create table if not exists composition_item (
    composition_id int NOT NULL REFERENCES tea_composition /*todo delete update*/,
    product_id int NOT NULL REFERENCES tea /*todo delete update*/,
    amount real NOT NULL
);

create table if not exists circuit_board_model (
    id varchar(128),
    version varchar(128),
    element_gap real NOT NULL,
    hole_diameter real NOT NULL,
    stiffness real NOT NULL,
    thermal_expansion_coef real NOT NULL,
    primary key (id, version)
);

create table if not exists circuit_board_machine (
    id serial primary key,
    assembly_date date NOT NULL,
    work_hrs real,
    area real /*todo что это*/,
    state curcuit_board_machine_state NOT NULL
);

create table if not exists circuit_board_machine_param_item (
    machine_id int NOT NULL REFERENCES circuit_board_machine(id),
    board_model_id varchar(128) not null  /*todo delete update*/,
    board_model_version varchar(128) NOT NULL /*todo delete update*/,
    speed real,
    foreign key (board_model_id, board_model_version) references circuit_board_model(id, version)
);

create table if not exists customer (
    id serial PRIMARY KEY NOT NULL,
    type customer_type NOT NULL,
    fname varchar(255) NOT NULL,
    mname varchar(255),
    lname varchar(255) NOT NULL,
    email varchar(255) /*todo null?????*/,
    phone bigint /*todo null?????*/,
    ITIN int /*todo null?????*/,
    company_name varchar(255)
);

create table if not exists address (
    id serial PRIMARY KEY NOT NULL,
    owner_id int NOT NULL REFERENCES customer /*todo delete update*/,
    country varchar(255) NOT NULL,
    city varchar(255) NOT NULL,
    street varchar(255) NOT NULL,
    building int NOT NULL,
    comment text
);

create table if not exists "order" (
    id serial PRIMARY KEY NOT NULL,
    customer_id int NOT NULL REFERENCES customer /*todo delete update*/,
    address_id int NOT NULL REFERENCES address /*todo delete update*/,
    accepted timestamp,
    fulfilled timestamp,
    delivered timestamp,
    comment text
);

create table if not exists circuit_board (
    id serial NOT NULL,
    model_id varchar(128) NOT NULL /*todo delete update*/,
    model_version varchar(128) NOT NULL /*todo delete update*/,
    order_id int NOT NULL REFERENCES "order" /*todo delete update*/,
    assembled_by int NOT NULL REFERENCES circuit_board_machine /*todo delete update*/,
    price real NOT NULL,
    foreign key (model_id, model_version) references circuit_board_model(id, version)
);

create table if not exists order_item (
    order_id int NOT NULL REFERENCES "order" /*todo delete update*/,
    board_model_id varchar(128) NOT NULL  /*todo delete update*/,
    board_model_version varchar(128) NOT NULL  /*todo delete update*/,
    amount int NOT NULL,
    foreign key (board_model_id, board_model_version) references circuit_board_model(id, version)
);

create table if not exists delivery_truck (
    id serial PRIMARY KEY NOT NULL,
    order_id int NOT NULL REFERENCES "order" /*todo delete update*/,
    capacity int NOT NULL,
    delivery_by timestamp
);