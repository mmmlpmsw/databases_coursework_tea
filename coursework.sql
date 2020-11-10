drop table if exists store, product, store_item, tea_composition, store_item, tea, cupboard_item, composition_item,
    circuit_board_model, circuit_board_machine, circuit_board_machine_param_item, customer, address, "order",
    circuit_board, order_item, delivery_truck, factory_employee, tea_cupboard;
drop type if exists circuit_board_machine_state, customer_type;
CREATE TYPE circuit_board_machine_state AS ENUM ('ok', 'broken', 'decommissioned');
CREATE TYPE customer_type AS ENUM ('legal_entity', 'individual');

create table if not exists store (
    id serial PRIMARY KEY,
    name varchar(255) NOT NULL
);

create table if not exists product (
    id serial PRIMARY KEY,
    name varchar(255) NOT NULL
);

create table if not exists tea_composition (
    super_id serial PRIMARY KEY REFERENCES product on delete cascade on update cascade,
    created date NOT NULL,
    description text
);

create table if not exists store_item (
    store_id int REFERENCES store on delete cascade on update cascade,
    product_id int REFERENCES product on delete cascade on update cascade,
    amount real NOT NULL,
    primary key (store_id, product_id)
);

create table if not exists tea (
    super_id serial PRIMARY KEY REFERENCES product on delete cascade on update cascade,
    type varchar(128) NOT NULL,
    created date NOT NULL
);

create table if not exists factory_employee (
    id serial PRIMARY KEY,
    fname varchar(255) NOT NULL,
    mname varchar(255),
    lname varchar(255) NOT NULL
);

create table if not exists tea_cupboard (
    id serial PRIMARY KEY,
    owner_id int REFERENCES factory_employee on delete cascade on update cascade,
    color int check ( color > 0 and color < cast(x'FFFFFF' as int) ),
    capacity real check ( capacity > 0 )
);

create table if not exists cupboard_item (
    product_id int REFERENCES tea on delete cascade on update cascade,
    cupboard_id int REFERENCES tea_cupboard on delete cascade on update cascade,
    amount real NOT NULL check ( amount > 0 ),
    primary key (product_id, cupboard_id)
);

create table if not exists composition_item (
    composition_id int REFERENCES tea_composition on delete cascade on update cascade,
    product_id int REFERENCES tea on delete cascade on update cascade,
    amount_percent real NOT NULL check ( amount_percent between 0 and 100 ),
    primary key (composition_id, product_id)
);

create table if not exists circuit_board_model (
    id varchar(128),
    version varchar(128),
    element_gap real NOT NULL check ( element_gap > 0 ),
    hole_diameter real NOT NULL check ( hole_diameter > 0 ),
    stiffness real NOT NULL,
    thermal_expansion_coef real NOT NULL,
    primary key (id, version)
);

create table if not exists circuit_board_machine (
    id serial primary key,
    assembly_date date NOT NULL check ( assembly_date <= now() ) default now(),
    work_hrs real not null check ( work_hrs >= 0 ) default 0,
    area real not null check ( area > 0 ),
    state circuit_board_machine_state NOT NULL
);

create table if not exists circuit_board_machine_param_item (
    machine_id int REFERENCES circuit_board_machine(id) on update cascade on delete cascade,
    board_model_id varchar(128),
    board_model_version varchar(128),
    speed real not null check ( speed > 0 ),
    primary key (machine_id, board_model_id, board_model_version),
    foreign key (board_model_id, board_model_version) references circuit_board_model(id, version) on update cascade on delete cascade
);

create table if not exists customer (
    id serial PRIMARY KEY,
    type customer_type NOT NULL,
    fname varchar(255) NOT NULL,
    mname varchar(255),
    lname varchar(255) NOT NULL,
    email varchar(255) check ( email like '' )/*todo*/,
    phone bigint /*todo*/,
    ITIN bigint check ( ITIN >= 0 and ITIN < 10000000000000) default null,
    company_name varchar(255),
    check ( email is not null or phone is not null )
);

(?:[a-z0-9!#\$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#\$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f
\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:
        (?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)])

create table if not exists address (
    id serial PRIMARY KEY NOT NULL,
    owner_id int NOT NULL check(owner_id > 0) REFERENCES customer /*todo delete update*/,
    country varchar(255) NOT NULL,
    city varchar(255) NOT NULL,
    street varchar(255) NOT NULL,
    building int NOT NULL,
    comment text
);

create table if not exists "order" (
    id serial PRIMARY KEY NOT NULL,
    customer_id int NOT NULL check(customer_id > 0) REFERENCES customer /*todo delete update*/,
    address_id int NOT NULL check(address_id > 0) REFERENCES  address /*todo delete update*/,
    accepted timestamp,
    fulfilled timestamp,
    delivered timestamp,
    comment text
);

create table if not exists circuit_board (
    id serial NOT NULL,
    model_id varchar(128) NOT NULL /*todo delete update*/,
    model_version varchar(128) NOT NULL /*todo delete update*/,
    order_id int NOT NULL check(order_id > 0) REFERENCES "order" /*todo delete update*/,
    assembled_by int NOT NULL check(assembled_by > 0) REFERENCES circuit_board_machine /*todo delete update*/,
    price real NOT NULL,
    foreign key (model_id, model_version) references circuit_board_model(id, version)
);

create table if not exists order_item (
    order_id int NOT NULL check(order_id > 0) REFERENCES "order" /*todo delete update*/,
    board_model_id varchar(128) NOT NULL  /*todo delete update*/,
    board_model_version varchar(128) NOT NULL  /*todo delete update*/,
    amount int NOT NULL,
    foreign key (board_model_id, board_model_version) references circuit_board_model(id, version)
);

create table if not exists delivery_truck (
    id serial PRIMARY KEY NOT NULL,
    order_id int NOT NULL check(order_id > 0) REFERENCES "order" /*todo delete update*/,
    capacity int NOT NULL,
    delivery_by timestamp
);