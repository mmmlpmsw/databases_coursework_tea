drop table if exists store, product, store_item, tea_composition, store_item, tea, cupboard_item, composition_item,
    circuit_board_model, circuit_board_machine, employee_machine_xref, circuit_board_machine_param_item, customer, address, "order",
    circuit_board, order_item, delivery_truck, factory_employee, tea_cupboard;
drop type if exists circuit_board_machine_state, customer_type;
CREATE TYPE circuit_board_machine_state AS ENUM ('ok', 'broken', 'decommissioned');
CREATE TYPE customer_type AS ENUM ('legal_entity', 'individual');

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

create table if not exists tea_cupboard (
    id serial primary key,
    owner_id int references factory_employee on delete cascade on update cascade,
    color int check ( color > 0 and color < cast(x'FFFFFF' as int) ),
    capacity real check ( capacity > 0 )
);

---------------------

create table if not exists tea_composition (
    super_id serial primary key references product on delete cascade on update cascade,
    created date not null,
    description text
);

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
    product_id int references tea on delete cascade on update cascade  /*todo что, если из таблицы чаев удаляется чай? он удалится и из композиции?*/,
    amount_percent real not null check ( amount_percent between 0 and 100 ),
    primary key (composition_id, product_id)
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

create table if not exists "order" (
    id serial primary key,
    customer_id int not null check(customer_id > 0) references customer on delete cascade on update cascade,
    address_id int not null check(address_id > 0) references address on delete cascade on update restrict, -- if customer delete his address, we could lose existing order
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
    delivery_by timestamp not null
);

insert into store(name) values
    ('Prisma'), ('Products'), ('Red Dragon'), ('Magnet'), ('Real'), ('Diksi'), ('Green Bean'), ('Okey'),
    ('Lenta'), ('Vkusvill'), ('Auchan'), ('Perekrestok'),  ('Red and White'), ('Azbuka vkusa');
insert into product(name) values
        ('Lipton'), --id = 1
        ('Richard'), --id = 2
        ('Tess'), --id = 3
        ('Greenfield'), --id = 4
        ('Curtis'), --id = 5
        ('Nordqvist'), --id = 6
        ('Matcha'),
        ('Merci milk'), ('Merci dark'), ('Ritter Sport Yogurt'), ('Ritter Sport Marzipan'), ('Ritter Sport Aalmond'), ('Ritter Sport Hazelnut'),
        ('Barilla spaghetti'), ('Barilla fetuccini'), ('Barilla fusilli'), ('Barilla penne'),
        ('Rich orange'), ('Rich apple'), ('Rich multifruit'), ('Rich tomato'), ('Rich grapefruit'),
        ('President cheese chocolate'), ('President cheese cream'), ('President cheese with ham'),
        ('Ristorante Margarita'), ('Ristorante Pepperoni-Salami'), ('Ristorante Four cheeses'),
        ('Almette cheeese with herbs'), ('Almette cheeese creamy'), ('Dolce parmesan'),
        ('Bounty'), ('Mars'), ('Snickers'), ('Twix'), ('Milky Way'),
        ('Pepsi'), ('Mirinda'), ('Seven up'), ('Pepsi'), ('Pepsi Light'), ('Coca Cola'), ('Coca Cola zero'),
        ('Pringles original'), ('Pringles sour cream&onion'), ('Pringles Paprika'),
        ('Valio mango'), ('Valio strawberry&blackberry'), ('Alpro barista'), ('Alpro Cashew'), ('Alpro coconut'), (''),
        ('Barilla Basilico'), ('Barilla Pesto'),
        ('Adrenaline Juicy'), ('Adrenalin Rush Game Fuel'), ('Schweppes'), ('Borjomi'), ('Bon Aqua'),
        ('Baikal'), ('Aqua Mineralle'), ('Voss'), ('Antipodes'),
        ('Haski'), ('Singleton'), ('Jim Bean Bourbon'), ('Baileys'), ('Beherovka'), ('Yagermeister'), ('Waildmeister'),
        ('Vana Tallinn'), ('Advocaat'), ('Blue Curacao'), ('Triple Sec'),
        ('Morosha'), ('Absolut'), ('Stolichnaya'), ('Lednik'), ('Talka'), ('Beluga'),
        ('Santo Stefano'), ('Perlino'), ('Frontera'), ('Chateau Picard Bordeaux'),
        ('Orange'), ('Lemon'), ('Banana'), ('Qiwi'), ('Pomegranate'), ('Pomelo'), ('Grapefruit'),
        ('Pineapple'), ('Apple'), ('Peach'), ('Pear'), ('Coconut'), ('Lime'), ('Ginger'),
        ('Nesquik'), ('Jacobs Monarch'), ('Jacobs Espresso'), ('Jacobs Crema'), ('Jacobs Barista Crema'),
        ('Jardin Kenya Kilimanjaro'), ('Jardin Colombia Medellin'), ('Jardin Guatemala Atitlan'),
        ('Nescafe Gold'), ('Nescafe Classic'),
        ('Salt'), ('Sugar'), ('Brown sugar'), ('Sweetener'),
        ('Dried mint'), ('Cinnamon'), ('Dried rosehip'), ('Strawberry'), ('Dried Thyme'), ('Dried marjoram'),
        ('Honey'), ('Licorice'), ('Tangerine'), ('Mango'),
        ('Potato'), ('Tomato'), ('Onion'), ('Avocado'), ('Carrot'), ('Brokkoli'), ('Salad'), ('Cucumber'),
        ('Garlic'), ('Pepper');


insert into factory_employee(lname, fname, mname) values
('Arkhipov', 'Dmitriy', 'Vsevolodovich'), ('Borodin', 'Aleksandr', 'Vladislavovich'), ('Voronkov', 'Anton', 'Bogdanovich'),
('Golovanov', 'Nikolay', 'Egorovich'), ('Guseva', 'Kseniya', 'Fedorovna'), ('Denisov', 'Grigoriy', 'Aleksandrovich'),
('Zhukov', 'Georgiy', 'Artemovich'), ('Zhuravlev', 'Lev', 'Bogdanovich'), ('Zimin', 'Aleksandr', 'Miroslavovich'),
('Karpova', 'Milena', 'Matveevna'), ('Kirillov', 'Vladimir', 'Glebovich'), ('Kudryavtseva', 'Ulyana', 'Nikolaevna'),
('Kulikov', 'Egor', 'Ilich'), ('Maltseva', 'Sofiya', 'Andreevna'), ('Melnikova', 'Vasilisa', 'Viktorovna'),
('Meshcheryakov', 'Andrey', 'Fedorovich'), ('Mikhaylov', 'Nikita', 'Ivanovich'), ('Morozov', 'Boris', 'Romanovich'),
('Novikov', 'Mikhail', 'Aleksandrovich'), ('Osipov', 'Stepan', ''), ('Pakhomov', 'Lev', ''),
('Platonov', 'Mikhail', 'Maksimovich'), ('Popov', 'Aleksandr', 'Egorovich'), ('Semenov', 'Aleksey', 'Stepanovich'),
('Sidorov', 'Leonid', 'Timofeevich'), ('Sokolov', 'Dmitriy', 'Maksimovich'), ('Sofronov', 'Maksim', 'Andreevich'),
('Troitskaya', 'Polina', ''), ('Fokin', 'Ilya', 'Vladimirovich'), ('Fomichev', 'Aleksandr', 'Kirillovich');

insert into tea(super_id, type, created) values
--      todo ключи
        (1, 'Lipton Green', '2020-08-18'), (1, 'Lipton Black', '2020-08-19'),
        (2, 'Richard Green', '2020-10-10'), (2, 'Richard Ceylon', '2020-10-30'),
        (3, 'Tess Pina Colada', '2020-07-10'), (3, 'Tess Pleasure', '2020-10-15'),
        (4, 'Greenfield  Golden Ceylon', '2020-01-10'), (4, 'Greenfield Earl Grey Fantasy', '2020-07-25'), (4, 'Greenfield Classic Breakfast', '2020-11-20'), (4, 'Greenfield Milky Oolong', '2020-09-21'),
            (4, 'Greenfield Spring Melody', '2020-11-20'), (4, 'Greenfield Honey Linden', '2020-09-06'), (4, 'Greenfield Blueberry Nights', '2020-11-20'), (4, 'Greenfield Ginger Red', '2020-09-06'),
            (4, 'Greenfield Green Melissa', '2020-11-20'), (4, 'Greenfield Floral Cloud', '2020-09-06'), (4, 'Greenfield Mellow Peach', '2020-11-20'), (4, 'Greenfield Spirit Mate', '2020-09-06'),
            (4, 'Greenfield Tropical Sunset', '2020-11-20'), (4, 'Greenfield Mint&Chocolate', '2020-09-06'), (4, 'Greenfield Golden Kiwi', '2020-11-20'), (4, 'Greenfield Blueberry Forest', '2020-09-06'),
        (5, 'Curtis Fresh Mojito', '2020-07-01'), (5, 'Curtis Strawberry Cake', '2020-07-03'), (5, 'Curtis Banana Flambe', '2020-04-01'), (5, 'Curtis Charming Cherry', '2020-10-04'), (5, 'Curtis Sunny Lemon', '2020-09-29'),
            (5, 'Curtis Isabella Grape', '2020-03-01'), (5, 'Curtis Summer Berries', '2020-07-07'), (5, 'Curtis Mirabel Plum', '2020-09-03'), (5, 'Curtis Earl Grey Passion', '2020-07-01'),
        (6, 'Nordqvist China Gunpowder', '2020-06-01'), (6, 'Nordqvist Keisarin Morsian', '2020-06-01'), (6, 'Nordqvist Muumimamman Voimajuoma', '2020-07-01'), (6, 'Nordqvist Tiikerin Päiväuni', '2020-07-01'), (6, 'Nordqvist China Green', '2020-06-05'),
            (6, 'Nordqvist Olet Ihana', '2020-08-12'),  (6, 'Nordqvist Päivän Paras Hetki', '2020-08-14'),  (6, 'Nordqvist Tsemppiä', '2020-07-25'),  (6, 'Nordqvist Viisasten Tee', '2020-03-30');

insert into tea_cupboard(owner_id, color, capacity) values
--      todo зачем id, когда есть однозначно определяемый owner_id (может ему стоит быть здесь primary?)
    (1, 8224519, 11), (2, 15779777, 32), (3, 14255763, 38),
    (4, 14800811, 35), (5, 14651479, 12), (6, 2165321, 14),
    (7, 15902016, 18), (8, 3564959, 24), (9, 15116092, 28),
    (10, 3948937, 22), (11, 10023666, 36), (12, 4568796, 39),
    (13, 1772249, 12), (14, 11295965, 24), (15, 599440, 39),
    (16, 6475528, 36), (17, 4700558, 35), (18, 14595368, 30),
    (19, 15491105, 12), (20, 673725, 25), (21, 8890817, 20),
    (22, 15895213, 20), (23, 6208931, 36), (24, 9746520, 21),
    (25, 6610611, 24), (26, 4363997, 37), (27, 15609806, 32),
    (28, 9613774, 28), (29, 2511184, 30), (30, 11973154, 35);

