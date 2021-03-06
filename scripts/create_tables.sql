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

-- drop types
do $$
begin
    execute coalesce(
        (
            SELECT distinct string_agg('drop type if exists "' || pg_type.typname || '" cascade;', '') FROM pg_type
                JOIN pg_enum ON pg_enum.enumtypid = pg_type.oid
        ),
        ''
    );
end
$$ language plpgsql;

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

-- trigger before insert
-- trigger after delete
create table if not exists tea (
    super_id serial primary key references product on delete cascade on update cascade,
    type varchar(128) not null,
    created date not null check (created <= now())
);

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

create type circuit_board_machine_state as enum ('ok', 'broken', 'decommissioned');
-- trigger after update of work_hrs
-- trigger after update of state
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
    speed_items_per_hour real not null check ( speed_items_per_hour > 0 ),
    primary key (machine_id, board_model_id, board_model_version),
    foreign key (board_model_id, board_model_version) references circuit_board_model(id, version) on update cascade on delete cascade
);

create type customer_type as enum ('legal_entity', 'individual');
create table if not exists customer (
    id serial primary key,
    type customer_type not null,
    fname varchar(255) not null,
    mname varchar(255),
    lname varchar(255) not null,
    email varchar(255) unique check (email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$'),
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

-- trigger before insert
-- trigger after delete
create table if not exists tea_composition (
    super_id serial primary key references product on delete cascade on update cascade,
    created date not null,
    name varchar not null,
    description text
);

-- trigger after update
create table if not exists store_item (
    store_id int references store on delete cascade on update cascade,
    product_id int references product on delete cascade on update cascade,
    amount real not null check ( amount >= 0 ),
    primary key (store_id, product_id)
);

-- trigger after update
-- trigger before insert x2
create table if not exists cupboard_item (
    product_id int references product on delete cascade on update cascade,
    cupboard_id int references tea_cupboard on delete cascade on update cascade,
    amount real not null check ( amount >= 0 ),
    primary key (product_id, cupboard_id)
);

create table if not exists composition_item (
    composition_id int references tea_composition on delete cascade on update cascade,
    product_id int references product on delete cascade on update cascade,
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

-- trigger after insert
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
    check ( order_id is not null and delivery_by is not null or order_id is null and delivery_by is null)
);

create table if not exists "user" (
    id serial primary key,
    login varchar(255) unique not null,
    name varchar(255) not null default 'Anonymous',
    password_hash varchar(88) not null, -- 512 bits in base64
    money bigint not null default 0
);

-- create table if not exists user_area_item (
--     user_id int not null references "user" on update cascade on delete cascade
--     -- todo
-- );

reassign owned by nadya to coursework_admin;