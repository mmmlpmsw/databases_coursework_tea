/**
  * функции и insert'ы для генерации большого количества начальных данных в таблицы
  * (исключительно для внутреннего пользования и удобства)
  * --------------------------------------------
  *
  * to be done: (желательно по мере выполнения переносить их из 'to be done' в готовые)
  * --todo insert individuals
  * --todo improve insert_employee_machine_xref
  *
  * ((просто чтобы не забыть, где недоделано - вероятно,
  * часть из них заполнится другими функциями))
  * вставка чайных композиций руками (которые должны быть мемные)
  * вставка в store_item
  * вставка в cupboard_item
  * вставка в composition_item
  * вставка в order
  * вставка в circuit_board
  * вставка в order_item
  * --todo индексы
  * --todo поправить отчет и диаграмму по итоговым таблицам, если останется время
 */

insert into store(name) values
    ('Prisma'), ('Products'), ('Red Dragon'), ('Magnet'), ('Real'), ('Diksi'), ('Green Bean'), ('Okey'),
    ('Lenta'), ('Vkusvill'), ('Auchan'), ('Perekrestok'),  ('Red and White'), ('Azbuka Vkusa');

insert into product(name) values
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

insert into tea(type, created) values
        ('Lipton Green', '2020-08-18'), ('Lipton Black', '2020-08-19'),
        ('Richard Green', '2020-10-10'), ('Richard Ceylon', '2020-10-30'),
        ('Tess Pina Colada', '2020-07-10'), ('Tess Pleasure', '2020-10-15'),
        ('Greenfield  Golden Ceylon', '2020-01-10'), ('Greenfield Earl Grey Fantasy', '2020-07-25'), ('Greenfield Classic Breakfast', '2020-11-20'), ('Greenfield Milky Oolong', '2020-09-21'),
            ('Greenfield Spring Melody', '2020-11-20'), ('Greenfield Honey Linden', '2020-09-06'), ('Greenfield Blueberry Nights', '2020-11-20'), ('Greenfield Ginger Red', '2020-09-06'),
            ('Greenfield Green Melissa', '2020-11-20'), ('Greenfield Floral Cloud', '2020-09-06'), ('Greenfield Mellow Peach', '2020-11-20'), ('Greenfield Spirit Mate', '2020-09-06'),
            ('Greenfield Tropical Sunset', '2020-11-20'), ('Greenfield Mint&Chocolate', '2020-09-06'), ('Greenfield Golden Kiwi', '2020-11-20'), ('Greenfield Blueberry Forest', '2020-09-06'),
        ('Curtis Fresh Mojito', '2020-07-01'), ('Curtis Strawberry Cake', '2020-07-03'), ('Curtis Banana Flambe', '2020-04-01'), ('Curtis Charming Cherry', '2020-10-04'), ('Curtis Sunny Lemon', '2020-09-29'),
            ('Curtis Isabella Grape', '2020-03-01'), ('Curtis Summer Berries', '2020-07-07'), ('Curtis Mirabel Plum', '2020-09-03'), ('Curtis Earl Grey Passion', '2020-07-01'),
        ('Nordqvist China Gunpowder', '2020-06-01'), ('Nordqvist Keisarin Morsian', '2020-06-01'), ('Nordqvist Muumimamman Voimajuoma', '2020-07-01'), ('Nordqvist Tiikerin Päiväuni', '2020-07-01'), ('Nordqvist China Green', '2020-06-05'),
            ('Nordqvist Olet Ihana', '2020-08-12'),  ('Nordqvist Päivän Paras Hetki', '2020-08-14'),  ('Nordqvist Tsemppiä', '2020-07-25'),  ('Nordqvist Viisasten Tee', '2020-03-30');

--------------------------------------------
/**
  * Функция для вставки сотрудников завода и их чайных шкафов.
  * Принимает массивы с фамилиями, именами, отчествами и вставляет
  * в таблицу factory_employee все возможные варианты их перебора.
 */

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
    FOR i IN 1..array_length(fnames, 1) LOOP
        FOR j IN 1..array_length(mnames, 1) LOOP
                FOR k IN 1..array_length(lnames, 1) LOOP
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

--------------------------------------------
/**
  * Функция для вставки модели печатной платы.
  * Принимает массивы с идентификаторами и версиями плат и вставляет
  * в таблицу factory_employee все возможные варианты их перебора.
  * Остальные параметры платы генерируются рандомно.
 */

CREATE OR REPLACE FUNCTION insert_circuit_board_model(ids varchar[],
                                                    versions varchar[]) RETURNS VOID AS
$$
DECLARE
    i integer := 0;
    j integer := 0;
BEGIN
    FOR i IN 1..array_length(ids, 1) LOOP
        FOR j IN 1..array_length(versions, 1) LOOP
                    insert into circuit_board_model values (ids[i], versions[j], (random()+0.1)::real,
                                                            (random() * 10 + 10)::real, (random() * 20 + 10)::real, (random()*90 + 25)::real);
        END LOOP;
    END LOOP;
END;
$$ LANGUAGE plpgSQL;

select insert_circuit_board_model(ARRAY['A320M', 'A320N', 'A321M', 'A321N', 'B420M', 'B420N', 'A320R', 'B420S', 'B440M', 'A230C', 'A453F'],
    ARRAY['A', 'B', 'C', 'D', 'E', 'F', 'J', 'H', 'I', 'K', 'L', 'M', 'N', 'O', 'P', 'R', 'S', 'T', 'U', 'Q', 'V', 'W', 'X', 'Y', 'Z',
         'AA', 'AB', 'AR', 'PR', 'HD', 'EA', 'NP', 'CF', 'LN', 'PI', 'ET', 'MJ', 'BT', 'TS', 'JP', 'JS', 'CS']);

--------------------------------------------
/**
  * Здесь находится процесс создания машин для производства печатных плат.
  * random_past генерирует дату в диапазоне [н.в. - years; н.в.]
  * insert_circuit_board_machine принимает кол-во каждого из типов машин и вставляет их в таблицу
  * Остальные параметры машины генерируются рандомно.
 */

create or replace function random_past(years int) returns timestamp as
$$
    begin
        return to_timestamp(extract(epoch from (now() - to_timestamp(random()*86400*365*years))));
    end
$$ language plpgsql;

CREATE OR REPLACE FUNCTION insert_circuit_board_machine(ok_count integer, broken_count integer, discomissioned_count integer) RETURNS void AS
$$
DECLARE
    i integer := 0;

BEGIN
    FOR i IN 1..ok_count LOOP
         insert into circuit_board_machine(assembly_date, work_hrs, area, state) values (random_past(10), (random() * 500 + 0)::real,
                                                  (random() * 100 + 1)::real, 'ok');
    END LOOP;
    FOR i IN 1..broken_count LOOP
        insert into circuit_board_machine(assembly_date, work_hrs, area, state) values (random_past(10), (random() * 500 + 0)::real,
                                                  (random() * 100 + 1)::real, 'broken');
    END LOOP;
    FOR i IN 1..discomissioned_count LOOP
        insert into circuit_board_machine(assembly_date, work_hrs, area, state) values (random_past(10), (random() * 500 + 0)::real,
                                                  (random() * 100 + 1)::real, 'decommissioned');
    END LOOP;
END;
$$ LANGUAGE plpgSQL;

select insert_circuit_board_machine(50, 5, 10);

--------------------------------------------
/**
  * Доработать!!!!!!!
  * Здесь находится процесс закрепления сотрудников завода за машинами, производящими платы.
  * Сейчас функция ставит на одну машину нескольких сотрудников.
  * Надо превратить это в many-to-many!
  * + момент с тем, как быть с машинами, которые discomissioned и broken
  * insert_circuit_board_machine принимает кол-во каждого из типов машин и вставляет их в таблицу
  * Остальные параметры машины генерируются рандомно.
 */

CREATE OR REPLACE FUNCTION insert_employee_machine_xref(employees_count integer, machines_count integer) RETURNS VOID AS
$$
DECLARE
    i integer := 0;
    employee_on_one_machine integer := 0;
    count integer := 0;
    machine_id integer := 1;
BEGIN
    employee_on_one_machine = employees_count / machines_count;
--     RAISE NOTICE 'employee_on_one_machine(%)', employee_on_one_machine;
    FOR i IN 1..employees_count LOOP
        count := count + 1;
        IF count = employee_on_one_machine and machine_id < machines_count THEN
            machine_id := machine_id + 1;
            count := 0;
        ELSIF count = employee_on_one_machine and machine_id = machines_count THEN
            count := 0;
        END IF;
        insert into employee_machine_xref values (i, machine_id);
    END LOOP;
END;
$$ LANGUAGE plpgSQL;

select insert_employee_machine_xref(3375, 65); --todo при переходе из ok -> broken/discomissioned куда сотрудника?

--------------------------------------------
/**
  * Функция для заполнения характеристик машин и производимых ими плат.
  * Принимает кол-во машин и кол-во моделей печатных плат.
  * Берет модели плат подряд из таблицы и на каждую рандомит по одной машине, которая может ее производить.
  * Скорость выпуска одной платы на машине вычисляется рандомно.
 */

DROP FUNCTION insert_circuit_board_machine_param_item(integer,integer);
CREATE OR REPLACE FUNCTION insert_circuit_board_machine_param_item(machines_count integer, cbmodels_count integer) RETURNS VOID AS
$$
DECLARE
    i integer := 0;
    random_speed integer := 0;
    circuit_board_model_row circuit_board_model%ROWTYPE;
    machine_id integer := 0;
BEGIN
    FOR i IN 1..cbmodels_count LOOP
        machine_id = (random() * (machines_count - 1) + 1)::integer;
        SELECT id, version into circuit_board_model_row FROM circuit_board_model ORDER BY id LIMIT 1 OFFSET i;
        random_speed := (random() * ( 100 - 10) + 10)::real;
        insert into circuit_board_machine_param_item values (machine_id, circuit_board_model_row.id, circuit_board_model_row.version, random_speed);
    END LOOP;

END
$$ LANGUAGE plpgSQL;

select insert_circuit_board_machine_param_item(65, 400);

--------------------------------------------
/**
  * Здесь находится процесс вставки в таблицы заказчиков.
  * insert_legal_entities принимает массивы фамилий, имен, отчеств, почт и названий компаний.
  * Номер телефона и ИНН генерируются рандомно
  *
  * insert_individuals
 */

CREATE OR REPLACE FUNCTION insert_legal_entities(legal_entity_count integer, fnames varchar[], mnames varchar[],
                                            lnames varchar[], emails varchar[], companies_names varchar[]) RETURNS VOID AS
$$
DECLARE
    i integer := 0;
    phone bigint := 0;
    ITIN bigint := 0;
BEGIN
    FOR i IN 1..legal_entity_count LOOP
        phone := (random() * (9999999999 - 9000000000) + 9000000000)::bigint;
        ITIN := (random() * (9999999999 - 0) + 0)::bigint;
        insert into customer(type, fname, mname, lname, email, phone, ITIN, company_name)
        VALUES ('legal_entity', fnames[i], mnames[i], lnames[i],emails[i], phone, ITIN, companies_names[i]);
    END LOOP;

END
$$ LANGUAGE plpgSQL;

-- http://imja.name/familii/pyatsot-chastykh-familij.shtml
select insert_legal_entities(10, ARRAY['Anatoliy', 'Vyacheslav', 'Yan', 'Konstantin', 'Oleg', 'Pavel', 'Pyotr', 'Fedor', 'Platon', 'Rodion', 'Alexander'],
    ARRAY['Aleksandrovich', 'Edouardovich', 'Borisovich', '', '', 'Fedorovich', 'Filippovich', 'Georgiyevich', 'Grigoryevich', ''],
    ARRAY['Ivanov', 'Smirnov', 'Kuznetsov', 'Popov', 'Vasilyev', 'Petrov', 'Sokolov', 'Mikhaylov', 'Novikov', 'Fedorov'],
    ARRAY['zfsseugrvc@gmail.com', 'gztxvgvacj@gmail.com', 'jgqmwjigdr@gmail.com', 'wzdpukvkrm@gmail.com', 'haxsdhokzf@gmail.com', 'rgvxlfzchs@gmail.com', 'zejtpivlls@gmail.com', 'fjetsheccb@gmail.com', 'xgwcrxhslf@gmail.com', 'enhppseqcn@gmail.com'],
    ARRAY['CODENETIX', 'INSIGHTWHALE', 'AZOFT', 'FIRST LINE SOFTWARE', 'SHOPDEV', 'Veeam Software', 'Luxoft', 'TeamDev', 'T-Systems CIS', 'ScienceSoft Inc.']);
-- http://imja.name/familii/pyatsot-chastykh-familij.shtml

--todo insert individuals
--
-- CREATE OR REPLACE FUNCTION insert_individuals(individuals_count integer, fnames varchar[], mnames varchar[],
--                                             lnames varchar[], emails varchar[]) RETURNS VOID AS
-- $$
-- DECLARE
--     i integer := 0;
--     phone bigint := 0;
--     ITIN bigint := 0;
-- BEGIN
--     FOR i IN 1..individuals_count LOOP
--         phone := (random() * (9999999999 - 9000000000) + 9000000000)::bigint;
--         ITIN := (random() * (9999999999 - 0) + 0)::bigint;
--         insert into customer(type, fname, mname, lname, email, phone, ITIN, company_name)
--         VALUES ('individual', fnames[i], mnames[i], lnames[i],emails[i], phone, ITIN, '');
--     END LOOP;
--
-- END
-- $$ LANGUAGE plpgSQL;

-- select insert_individuals(150, );

--------------------------------------------
/**
  * Заполнение таблицы адресов.
  * Принимает кол-во записей в таблицу, массивы с городами и улицами
  * на каждом шаге вычисляет рандомные индексы для массивов
  * городов, улиц и рандомный номер дома
  * и вставляет в таблицу address строки с элементами с
  * рандомными индексами из вышеупомянутых массивов.
 */

CREATE OR REPLACE FUNCTION insert_address(entity_count integer, city varchar[], street varchar[]) RETURNS VOID AS
$$
DECLARE
    i integer := 0;
    random_city_idx integer := 0;
    random_street_idx integer := 0;
    random_building integer := 0;
BEGIN
    FOR i IN 1..entity_count LOOP
        random_city_idx := (random() * (array_length(city, 1) - 1) + 1)::integer;
        random_street_idx := (random() * (array_length(street, 1) - 1) + 1)::integer;
        random_building := (random() * (150 - 1) + 1)::integer;
       insert into address(owner_id, country, city, street, building, comment)
       VALUES (i, 'Russian Federation', city[random_city_idx], street[random_street_idx], random_building, '');
    END LOOP;

END
$$ LANGUAGE plpgSQL;
-- http://translit-online.ru
-- http://ulitsa.eu/top.php
select insert_address(10, ARRAY['Moscow', 'Petrozavodsk', 'Rostov-on-Don', 'Saint Petersburg', 'Tomsk', 'Ufa', 'Yaroslavl', 'Omsk', 'Kaliningrad', 'Kazan'],
    ARRAY['Centralnaya, ul.', 'Molodezhnaya, ul.', 'Shkolnaya, ul.', 'Lesnaya, ul.', 'Sovetskaya, ul.', 'Novaya, ul.', 'Sadovaya, ul.', 'Naberezhnaya, ul.', 'Zarechnaya, ul.',
        'Zelenaya, ul.', 'Mira, ul.', 'Lenina, ul.', 'Polevaya, ul.', 'Lugovaya, ul.', 'Oktyabrskaya, ul.', 'Komsomolskaya, ul.',
        'Gagarina, ul.', 'Pervomajskaya, ul.', 'Severnaya, ul.', 'Solnechnaya, ul.', 'Stepnaya, ul.', 'YUzhnaya, ul.', 'Beregovaya, ul.', 'Kirova, ul.', 'Pionerskaya, ul.']
    );

--------------------------------------------
/**
  * Заполнение таблицы грузовиков доставки плат.
  * Принимает кол-во грузовиков
  * Для каждого грузовика рандомно вычисляет вместимость
  * Первоначально поля, связанные с заказом не инициализированы
 */

CREATE OR REPLACE FUNCTION insert_delivery_truck(trucks_count integer) RETURNS VOID AS
$$
DECLARE
    i integer := 0;
    random_capacity integer := 0;
BEGIN
    FOR i IN 1..trucks_count LOOP
       random_capacity := (random() * (150 - 10) + 10)::integer;
       insert into delivery_truck(order_id, capacity, delivery_by)
       VALUES (NULL, random_capacity, NULL);
    END LOOP;

END
$$ LANGUAGE plpgSQL;

select insert_delivery_truck(20);

--------------------------------------------