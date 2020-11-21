-- insert into store(name) values
--     ('Prisma'), ('Products'), ('Red Dragon'), ('Magnet'), ('Real'), ('Diksi'), ('Green Bean'), ('Okey'),
--     ('Lenta'), ('Vkusvill'), ('Auchan'), ('Perekrestok'),  ('Red and White'), ('Azbuka vkusa');
-- insert into product(name) values
--         ('Lipton'), --id = 1
--         ('Richard'), --id = 2
--         ('Tess'), --id = 3
--         ('Greenfield'), --id = 4
--         ('Curtis'), --id = 5
--         ('Nordqvist'), --id = 6
--         ('Matcha'),
--         ('Merci milk'), ('Merci dark'), ('Ritter Sport Yogurt'), ('Ritter Sport Marzipan'), ('Ritter Sport Aalmond'), ('Ritter Sport Hazelnut'),
--         ('Barilla spaghetti'), ('Barilla fetuccini'), ('Barilla fusilli'), ('Barilla penne'),
--         ('Rich orange'), ('Rich apple'), ('Rich multifruit'), ('Rich tomato'), ('Rich grapefruit'),
--         ('President cheese chocolate'), ('President cheese cream'), ('President cheese with ham'),
--         ('Ristorante Margarita'), ('Ristorante Pepperoni-Salami'), ('Ristorante Four cheeses'),
--         ('Almette cheeese with herbs'), ('Almette cheeese creamy'), ('Dolce parmesan'),
--         ('Bounty'), ('Mars'), ('Snickers'), ('Twix'), ('Milky Way'),
--         ('Pepsi'), ('Mirinda'), ('Seven up'), ('Pepsi'), ('Pepsi Light'), ('Coca Cola'), ('Coca Cola zero'),
--         ('Pringles original'), ('Pringles sour cream&onion'), ('Pringles Paprika'),
--         ('Valio mango'), ('Valio strawberry&blackberry'), ('Alpro barista'), ('Alpro Cashew'), ('Alpro coconut'), (''),
--         ('Barilla Basilico'), ('Barilla Pesto'),
--         ('Adrenaline Juicy'), ('Adrenalin Rush Game Fuel'), ('Schweppes'), ('Borjomi'), ('Bon Aqua'),
--         ('Baikal'), ('Aqua Mineralle'), ('Voss'), ('Antipodes'),
--         ('Haski'), ('Singleton'), ('Jim Bean Bourbon'), ('Baileys'), ('Beherovka'), ('Yagermeister'), ('Waildmeister'),
--         ('Vana Tallinn'), ('Advocaat'), ('Blue Curacao'), ('Triple Sec'),
--         ('Morosha'), ('Absolut'), ('Stolichnaya'), ('Lednik'), ('Talka'), ('Beluga'),
--         ('Santo Stefano'), ('Perlino'), ('Frontera'), ('Chateau Picard Bordeaux'),
--         ('Orange'), ('Lemon'), ('Banana'), ('Qiwi'), ('Pomegranate'), ('Pomelo'), ('Grapefruit'),
--         ('Pineapple'), ('Apple'), ('Peach'), ('Pear'), ('Coconut'), ('Lime'), ('Ginger'),
--         ('Nesquik'), ('Jacobs Monarch'), ('Jacobs Espresso'), ('Jacobs Crema'), ('Jacobs Barista Crema'),
--         ('Jardin Kenya Kilimanjaro'), ('Jardin Colombia Medellin'), ('Jardin Guatemala Atitlan'),
--         ('Nescafe Gold'), ('Nescafe Classic'),
--         ('Salt'), ('Sugar'), ('Brown sugar'), ('Sweetener'),
--         ('Dried mint'), ('Cinnamon'), ('Dried rosehip'), ('Strawberry'), ('Dried Thyme'), ('Dried marjoram'),
--         ('Honey'), ('Licorice'), ('Tangerine'), ('Mango'),
--         ('Potato'), ('Tomato'), ('Onion'), ('Avocado'), ('Carrot'), ('Brokkoli'), ('Salad'), ('Cucumber'),
--         ('Garlic'), ('Pepper');
--
--

--


-- insert into tea(super_id, type, created) values
-- --      todo ключи
--         (1, 'Lipton Green', '2020-08-18'), (1, 'Lipton Black', '2020-08-19'),
--         (2, 'Richard Green', '2020-10-10'), (2, 'Richard Ceylon', '2020-10-30'),
--         (3, 'Tess Pina Colada', '2020-07-10'), (3, 'Tess Pleasure', '2020-10-15'),
--         (4, 'Greenfield  Golden Ceylon', '2020-01-10'), (4, 'Greenfield Earl Grey Fantasy', '2020-07-25'), (4, 'Greenfield Classic Breakfast', '2020-11-20'), (4, 'Greenfield Milky Oolong', '2020-09-21'),
--             (4, 'Greenfield Spring Melody', '2020-11-20'), (4, 'Greenfield Honey Linden', '2020-09-06'), (4, 'Greenfield Blueberry Nights', '2020-11-20'), (4, 'Greenfield Ginger Red', '2020-09-06'),
--             (4, 'Greenfield Green Melissa', '2020-11-20'), (4, 'Greenfield Floral Cloud', '2020-09-06'), (4, 'Greenfield Mellow Peach', '2020-11-20'), (4, 'Greenfield Spirit Mate', '2020-09-06'),
--             (4, 'Greenfield Tropical Sunset', '2020-11-20'), (4, 'Greenfield Mint&Chocolate', '2020-09-06'), (4, 'Greenfield Golden Kiwi', '2020-11-20'), (4, 'Greenfield Blueberry Forest', '2020-09-06'),
--         (5, 'Curtis Fresh Mojito', '2020-07-01'), (5, 'Curtis Strawberry Cake', '2020-07-03'), (5, 'Curtis Banana Flambe', '2020-04-01'), (5, 'Curtis Charming Cherry', '2020-10-04'), (5, 'Curtis Sunny Lemon', '2020-09-29'),
--             (5, 'Curtis Isabella Grape', '2020-03-01'), (5, 'Curtis Summer Berries', '2020-07-07'), (5, 'Curtis Mirabel Plum', '2020-09-03'), (5, 'Curtis Earl Grey Passion', '2020-07-01'),
--         (6, 'Nordqvist China Gunpowder', '2020-06-01'), (6, 'Nordqvist Keisarin Morsian', '2020-06-01'), (6, 'Nordqvist Muumimamman Voimajuoma', '2020-07-01'), (6, 'Nordqvist Tiikerin Päiväuni', '2020-07-01'), (6, 'Nordqvist China Green', '2020-06-05'),
--             (6, 'Nordqvist Olet Ihana', '2020-08-12'),  (6, 'Nordqvist Päivän Paras Hetki', '2020-08-14'),  (6, 'Nordqvist Tsemppiä', '2020-07-25'),  (6, 'Nordqvist Viisasten Tee', '2020-03-30');
--




DROP FUNCTION insert_employees_and_cupboards(character varying[],character varying[],character varying[]);
CREATE OR REPLACE FUNCTION insert_employees_and_cupboards(fnames varchar[],
                                            mnames varchar[],
                                            lnames varchar[]) RETURNS void AS
$$
DECLARE
    i integer := 0;
    j integer := 0;
    k integer := 0;
    count integer := 0;
BEGIN
    FOR i IN 1..15 LOOP
        FOR j IN 1..15 LOOP
                FOR k IN 1..15 LOOP
                        count:= count + 1;
                        insert into factory_employee(fname, mname, lname) values (fnames[i], mnames[j], lnames[k]);
                        insert into tea_cupboard(owner_id, color, capacity) values (count, floor(random() * (16777215 - 0) + 0)::int, floor(random() * (40 - 10) + 10)::int);
                END LOOP;
        END LOOP;
    END LOOP;
END;
$$ LANGUAGE plpgSQL;

select insert_employees_and_cupboards(ARRAY['Dmitriy', 'Leonid', 'Ilya', 'Boris', 'Miron', 'Nikita', 'Egor', 'Stepan', 'Andrey', 'Aleksandr', 'Anton', 'Grigoriy', 'Georgiy', 'Lev', 'Vladimir'],
    ARRAY['Vsevolodovich', 'Ivanovich', 'Maksimovich', 'Timofeevich', 'Vladislavovich', 'Bogdanovich', 'Egorovich', 'Aleksandrovich', 'Artemovich', 'Bogdanovich', 'Miroslavovich', 'Glebovich', 'Romanovich', '', 'Andreevich'],
    ARRAY['Arkhipov', 'Borodin', 'Voronkov', 'Golovanov', 'Denisov', 'Zhukov', 'Zhuravlev', 'Zimin', 'Kirillov', 'Kulikov', 'Pakhomov', 'Semenov', 'Sofronov', 'Fokin', 'Osipov']);

CREATE OR REPLACE FUNCTION insert_circuit_board_model(ids varchar[],
                                                    versions varchar[]) RETURNS VOID AS
$$
DECLARE
    i integer := 0;
    j integer := 0;
BEGIN
    FOR i IN 1..8 LOOP
        FOR j IN 1..37 LOOP
                    insert into circuit_board_model values (ids[i], versions[j], (random()+0.1)::real,
                                                            (random() * 10 + 10)::real, (random() * 20 + 10)::real, (random()*90 + 25)::real);
        END LOOP;
    END LOOP;
END;
$$ LANGUAGE plpgSQL;

select insert_circuit_board_model(ARRAY['A320M', 'A320N', 'A321M', 'A321N', 'B420M', 'B420N', 'A320R', 'B420S'],
    ARRAY['A', 'B', 'C', 'D', 'E', 'F', 'J', 'H', 'I', 'K', 'L', 'M', 'N', 'O', 'P', 'R', 'S', 'T', 'U', 'Q', 'V', 'W', 'X', 'Y', 'Z',
        'AA', 'AB', 'AR', 'PR', 'HD', 'EA', 'NP', 'CF', 'LN', 'PI', 'ET', 'MJ']);

DROP FUNCTION insert_circuit_board_machine(integer,integer,integer);
CREATE OR REPLACE FUNCTION insert_circuit_board_machine(ok_count integer, broken_count integer, discomissioned_count integer) RETURNS void AS
$$
DECLARE
    i integer := 0;

BEGIN
    FOR i IN 1..ok_count LOOP
        insert into circuit_board_machine(assembly_date, work_hrs, area, state) values (to_timestamp(random()*/*2*/147483647), (random() * 500 + 0)::real,
                                                  (random() * 100 + 1)::real, 'ok');
    END LOOP;
    FOR i IN 1..broken_count LOOP
        insert into circuit_board_machine(assembly_date, work_hrs, area, state) values (to_timestamp(random()*/*2*/147483647), (random() * 500 + 0)::real,
                                                  (random() * 100 + 1)::real, 'broken');
    END LOOP;
    FOR i IN 1..discomissioned_count LOOP
        insert into circuit_board_machine(assembly_date, work_hrs, area, state) values (to_timestamp(random()*/*2*/147483647), (random() * 500 + 0)::real,
                                                  (random() * 100 + 1)::real, 'decommissioned');
    END LOOP;
END;
$$ LANGUAGE plpgSQL;

select insert_circuit_board_machine(50, 5, 10);

CREATE OR REPLACE FUNCTION insert_employee_machine_xref(employees_count integer, machines_count integer) RETURNS VOID AS
$$
DECLARE
    i integer := 0;
    employee_on_one_machine integer := 0;
    count integer := 0;
BEGIN
    employee_on_one_machine = employees_count / machines_count;
    FOR i IN 1..employees_count LOOP
        insert into employee_machine_xref values (i, ((employees_count+i) % employee_on_one_machine + 1));
    END LOOP;
END;
$$ LANGUAGE plpgSQL;

select insert_employee_machine_xref(3300, 60); --todo при переходе из ok -> broken/discomissioned куда сотрудника?

create table if not exists circuit_board_machine_param_item (
    machine_id int references circuit_board_machine(id) on update cascade on delete cascade,
    board_model_id varchar(128),
    board_model_version varchar(128),
    speed real not null check ( speed > 0 ),
    primary key (machine_id, board_model_id, board_model_version),
    foreign key (board_model_id, board_model_version) references circuit_board_model(id, version) on update cascade on delete cascade
);

