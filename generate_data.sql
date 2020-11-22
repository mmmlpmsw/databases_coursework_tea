insert into store(name) values
    ('Prisma'), ('Products'), ('Red Dragon'), ('Magnet'), ('Real'), ('Diksi'), ('Green Bean'), ('Okey'),
    ('Lenta'), ('Vkusvill'), ('Auchan'), ('Perekrestok'),  ('Red and White'), ('Azbuka Vkusa');
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

--------------------------------------------
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
--fixme убрать если слишком много
select insert_circuit_board_model(
    ARRAY['AXZO-WRLV-QNPC',
'GOUG-XFXH-SONA', 'JLIX-YJMR-ODOH', 'DTWZ-QQVK-RTAQ','ZVTC-BXBN-OIOA','UGNZ-WQTS-WAWU','QQRE-VWCK-XYCV','CXZR-XCMW-MHVS',
'PIER-FRTM-OHIP', 'IKKI-OZMR-ZPNT', 'UYQX-BVPL-GXBW', 'ILKU-IYRR-CETJ','NWLZ-ZSKA-GNDX','GWUG-TIGE-YVEF','VNWC-JQPO-GCRD',
'NBJR-WPGW-XQON', 'IOPO-FXAU-TSBJ', 'RTKL-WOIG-VVBG', 'MNFX-LMSW-OVVD', 'DMYF-HQNW-FIQA', 'SLJP-NEGS-FNBF',
'JGJI-DBEK-XRAQ','NRKT-LFLZ-LPYB','FBJA-VRDL-LTQS','WGUY-HHGS-XJVX','BEYW-NQMU-MIMY','ZQDY-EQJV-JPOO','GGTX-BMYQ-CWWM',
'ARDU-QBBU-PGGP','KKIP-FQRY-EZRE','ORHH-XPVK-SQIN','YGCD-GDFV-AACM','RMYX-GHKM-BUPQ','LWCK-ZISA-IFOR','ADJD-DHRD-QYAD',
'DJVF-FWTS-XIEN','IDNS-QRYE-BCVK','KMLO-QFZK-OZQY','WHTZ-RHMP-ZGZW','GMBU-GUQY-LTTR','MBYY-DEGZ-RVOM','KZBG-THDT-OFMA',
'SWLR-UTQC-LFRG','IUVE-PWOT-VVUY','TZLT-XZET-LALL','AVCK-QHJH-GRBP','GFJQ-VEBT-VFTU','QKEB-PSDO-TOLZ','KCBP-KXRY-COHG',
'VGBE-BLJD-VJCF','NDYO-IDKY-LYLW','XNLF-XOQH-MSCV','JIHM-TJKT-QJOB','SZDM-RFEK-ZBWJ','LTCB-YOBJ-HGZY','HHBX-NWVB-KRAO',
'UFEF-FHQS-OQBD','OZRO-FYDL-NNLL','EYXT-POLJ-EAHU','HSXG-QQYA-RWBL'],
    ARRAY['80MA', 'A4TS', 'LV6A', 'XRSP', 'K9PK', 'RKL2', 'LF80', '9EPT', 'TT5S', '4V6N', '4PLM', '6NKK', 'L137', 'K5M9',
'8K7L', 'FXRE', '5678', '6X7T', 'RLRL', '5AEV', '8F2V', 'N86A', '5AXN', '87T6', 'AVAS', 'SK7M', '20TR', 'F9KM',
'6FL1', '7S43', 'RASV', 'SMAE', 'VXLT', '7347', '2TS8', 'RT85', '78LX', '6FT8', 'TAR7', '98EK', '6FX8', '3VE4',
'EEF6', '5M31', 'LR5N', 'KXM8', 'LA03', '4N31', 'RXX7', '7XS2', '0XVS', '63NM', 'XER7', 'SR93', 'X75F', '0RML',
'R213', '2N5M', 'TPKM', 'NVL8', 'XVPE', '53P8', 'MS1M', 'FPAM', '503M', '0A06', 'MAVM', 'S8PP', '91A4', '4NF0']);

--------------------------------------------

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

--------------------------------------------

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
        random_speed := (random() * ( 100 - 10) + 10)::real; --fixme пока что диапазон [10;100], а надо?
        insert into circuit_board_machine_param_item values (machine_id, circuit_board_model_row.id, circuit_board_model_row.version, random_speed);
    END LOOP;

END
$$ LANGUAGE plpgSQL;

select insert_circuit_board_machine_param_item(65, 666);

--------------------------------------------

CREATE OR REPLACE FUNCTION insert_legal_entities(legal_entity_count integer, fnames varchar[], mnames varchar[],
                                            lnames varchar[], emails varchar[], companies_names varchar[]/*, individual_count integer*/) RETURNS VOID AS
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

