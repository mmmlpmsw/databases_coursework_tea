/**
  * functions and inserts for generating a large amount of initial data in tables
  * (for internal use and convenience only)
  * --------------------------------------------
  * useful links:
  * -- http://translit-online.ru
  * -- http://ulitsa.eu/top.php
  * -- http://imja.name/familii/pyatsot-chastykh-familij.shtml
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
        ('Garlic'), ('Pepper'),
        ('Royal Canin sterilised'), ('Royal Canin kitten'),('Royal Canin mother&babycat'),('Royal Canin sensible'),('Royal Canin protein'),('Royal Canin fit'),('Royal Canin indoor'),
        ('Perfect Fit chicken'),('Perfect Fit beef'),('Perfect Fit turkey'),('Perfect Fit salmon'),
        ('Franks ProGold kitten'),('Franks ProGold light'),('Whiskas creamy sauce&shrimp&salmon'),('Whiskas tomato jelly&poultry&beef'),('Whiskas cream sauce&lamb&beef'),('Whiskas cheese sauce&chicken&duck'),('Whiskas beef'),('Whiskas chicken'),('Whiskas rabbit'),('Whiskas salmon'),
        ('Whiskas stew with veal'), ('Whiskas stew with rabbit and turkey'),('Whiskas stew with trout'),('Whiskas paté with veal'),('Whiskas paté with duck'),('Whiskas paté with chicken and turkey'),('Whiskas mini fillet of beef');

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

insert into customer(type, fname, mname, lname, email) values
('individual', 'Anton', 'Valerevich', 'Gavrilov', 'avgavrilov@itmo.ru'),
('individual', 'Sergej', 'Viktorovich', 'Klimenkov', 'klimenkov@itmo.ru'),
('individual', 'Evgenij', 'Alekseevich', 'Tsopa', 'evgenij.tsopa@itmo.ru'),
('individual', 'Vladimir', 'Vyacheslavovich', 'Nikolaev', 'vvnikolaev@itmo.ru'),
('individual', 'Alexey', 'Evgenjevich', 'Pismak', 'alexey.pismak@cs.ifmo.ru'),
('individual', 'Pavel', 'Valerevich', 'Balakshin', 'pvbalakshin@itmo.ru'),
('individual', 'Aleksandr', 'Sergeevich', 'Yarkeev', 'bleizard@cs.ifmo.ru'),
('individual', 'Ivan', 'Vladimirovich', 'Uskov', 'liveinkarai@gmail.com'),
('individual', 'Ilya', 'Valentinovich', 'Perminov', 'ivperminov@itmo.ru'),
('individual', 'Dmitrij', 'Borisovich', 'Afanasev', 'dima@cs.ifmo.ru');

--------------------------------------------
CREATE or replace FUNCTION fmod (
   dividend double precision,
   divisor double precision
) RETURNS double precision
    LANGUAGE sql IMMUTABLE AS
'SELECT dividend - floor(dividend / divisor) * divisor';

-- all values from 0 to 1
create or replace function hsv_to_rgb(hue double precision, saturation double precision, value double precision) returns integer as $$
declare
    c double precision := null;
    x double precision := null;
    m double precision := null;
    mr double precision := null;
    mg double precision := null;
    mb double precision := null;
    r double precision := null;
    g double precision := null;
    b double precision := null;
begin
    c := value * saturation;
    x := c * (1.0 - abs(fmod(hue*6, 2) - 1.0));
    m := value - c;
    if 0 <= hue and hue < 60.0/360 then
        mr := c; mg := x; mb := 0;
    elseif 60.0/360 <= hue and hue < 120.0/360 then
        mr := x; mg := c; mb := 0;
    elseif 120.0/360 <= hue and hue < 180.0/360 then
        mr := 0; mg := c; mb := x;
    elseif 180.0/360 <= hue and hue < 240.0/360 then
        mr := 0; mg := x; mb := c;
    elseif 240.0/360 <= hue and hue < 300.0/360 then
        mr := x; mg := 0; mb := c;
    else
        mr := c; mg := 0; mb := x;
    end if;

    r := (mr + m)*255;
    g := (mg + m)*255;
    b := (mb + m)*255;

    return floor(r)*256*256 + floor(g)*256 + floor(b);
end;
$$ language plpgsql;

/**
  * Функция для вставки сотрудников завода и их чайных шкафов.
  * Принимает массивы с фамилиями, именами, отчествами и вставляет
  * в таблицу factory_employee все возможные варианты их перебора.
 */
create or replace function insert_employees_and_cupboards(
    fnames varchar[],
    mnames varchar[],
    lnames varchar[]
)
returns void as $$
declare
    i integer := 0;
    j integer := 0;
    k integer := 0;
    count integer := 0;
begin
    for i in 1..array_length(fnames, 1) loop
        for j in 1..array_length(mnames, 1) loop
                for k in 1..array_length(lnames, 1) loop
                        count:= count + 1;
                        insert into factory_employee(fname, mname, lname) values (fnames[i], mnames[j], lnames[k]);
                        insert into tea_cupboard(owner_id, color, capacity)
                        values (
                                count,
                                hsv_to_rgb(random(), 1, 1),
                                floor(random() * (40 - 10) + 10)::int
                        );
                end loop;
        end loop;
    end loop;
end;
$$ language plpgSQL;

select insert_employees_and_cupboards(
    array['Dmitriy', 'Leonid', 'Ilya', 'Boris', 'Miron', 'Nikita', 'Egor', 'Stepan', 'Andrey', 'Aleksandr', 'Anton', 'Grigoriy', 'Georgiy', 'Lev', 'Vladimir'],
    array['Vsevolodovich', 'Ivanovich', 'Maksimovich', 'Timofeevich', 'Vladislavovich', 'Bogdanovich', 'Egorovich', 'Aleksandrovich', 'Artemovich', 'Bogdanovich', 'Miroslavovich', 'Glebovich', 'Romanovich', '', 'Andreevich'],
    array['Arkhipov', 'Borodin', 'Voronkov', 'Golovanov', 'Denisov', 'Zhukov', 'Zhuravlev', 'Zimin', 'Kirillov', 'Kulikov', 'Pakhomov', 'Semenov', 'Sofronov', 'Fokin', 'Osipov']);

--------------------------------------------
/**
  * Функция для вставки модели печатной платы.
  * Принимает массивы с идентификаторами и версиями плат и вставляет
  * в таблицу factory_employee все возможные варианты их перебора.
  * Остальные параметры платы генерируются рандомно.
 */

create or replace function insert_circuit_board_model(
    ids varchar[],
    versions varchar[]
)
returns void as $$
declare
    i integer := 0;
    j integer := 0;
begin
    for i in 1..array_length(ids, 1) loop
        for j in 1..array_length(versions, 1) loop
                    insert into circuit_board_model values (ids[i], versions[j], (random()+0.1)::real,
                                                            (random() * 10 + 10)::real, (random() * 20 + 10)::real, (random()*90 + 25)::real);
        end loop;
    end loop;
end;
$$ language plpgSQL;

select insert_circuit_board_model(array['A320M', 'A320N', 'A321M', 'A321N', 'B420M', 'B420N', 'A320R', 'B420S', 'B440M', 'A230C', 'A453F'],
    array['A', 'B', 'C', 'D', 'E', 'F', 'J', 'H', 'I', 'K', 'L', 'M', 'N', 'O', 'P', 'R', 'S', 'T', 'U', 'Q', 'V', 'W', 'X', 'Y', 'Z',
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

create or replace function insert_circuit_board_machine(
    ok_count integer,
    broken_count integer,
    discomissioned_count integer
)
returns void as $$
declare
    i integer := 0;
begin
    for i in 1..ok_count loop
         insert into circuit_board_machine(assembly_date, work_hrs, area, state) values (random_past(10), (random() * 500 + 0)::real,
                                                  (random() * 100 + 1)::real, 'ok');
    end loop;
    for i in 1..broken_count loop
        insert into circuit_board_machine(assembly_date, work_hrs, area, state) values (random_past(10), (random() * 500 + 0)::real,
                                                  (random() * 100 + 1)::real, 'broken');
    end loop;
    for i in 1..discomissioned_count loop
        insert into circuit_board_machine(assembly_date, work_hrs, area, state) values (random_past(10), (random() * 500 + 0)::real,
                                                  (random() * 100 + 1)::real, 'decommissioned');
    end loop;
end;
$$ language plpgSQL;

select insert_circuit_board_machine(50, 5, 10);

--------------------------------------------
/**
  * Здесь находится процесс закрепления сотрудников завода за машинами, производящими платы.
  * Сейчас функция ставит на одну машину нескольких сотрудников.
  * insert_circuit_board_machine принимает кол-во каждого из типов машин и вставляет их в таблицу
  * Остальные параметры машины генерируются рандомно.
 */

do $$
declare
    i integer := 0;
    machine_id integer := 0;
    employee_id integer := 0;
    employees_count integer := 0;
    machines_count integer := 0;
begin
    select count(*) from factory_employee into employees_count;
    select count(*) from circuit_board_machine into machines_count;

    for i in 1..employees_count loop
        select id from circuit_board_machine where state != 'decommissioned' order by random() limit 1 into machine_id;
        insert into employee_machine_xref values (i, machine_id) on conflict do nothing;
    end loop;

    for i in 1..machines_count loop
        select id from factory_employee order by random() limit 1 into employee_id;
        insert into employee_machine_xref values (employee_id, i) on conflict do nothing;
    end loop;

    delete from employee_machine_xref as emx where exists(
        select id from circuit_board_machine where state = 'decommissioned' and id = emx.machine_id
    );
end;
$$ language plpgSQL;

--------------------------------------------
/**
  * Функция для заполнения характеристик машин и производимых ими плат.
  * Принимает кол-во машин и кол-во моделей печатных плат.
  * Берет модели плат подряд из таблицы и на каждую рандомит по одной машине, которая может ее производить.
  * Скорость выпуска одной платы на машине вычисляется рандомно.
 */

create or replace function insert_circuit_board_machine_param_item(
    machines_count integer,
    cbmodels_count integer
)
returns void as $$
declare
    i integer := 0;
    random_speed integer := 0;
    circuit_board_model_row circuit_board_model%ROWTYPE;
    machine_id integer := 0;
begin
    for i in 1..cbmodels_count loop
        machine_id = (random() * (machines_count - 1) + 1)::integer;
        select id, version into circuit_board_model_row from circuit_board_model order by id limit 1 offset i;
        random_speed := (random() * ( 100 - 10) + 10)::real;
        insert into circuit_board_machine_param_item values (machine_id, circuit_board_model_row.id, circuit_board_model_row.version, random_speed);
    end loop;
END
$$ language plpgSQL;

select insert_circuit_board_machine_param_item(65, 400);

--------------------------------------------
/**
  * Здесь находится процесс вставки в таблицы заказчиков.
  * insert_legal_entities и insert_individuals принимают массивы фамилий, имен, отчеств и названий компаний.
  * Номер телефона, ИНН и почты генерируются рандомно
 */

create or replace function get_random_email(
    fname varchar,
    lname varchar
) returns varchar as $$
declare
    result varchar := '';
    domains varchar[] := array[
        'google.com',
        'yandex.ru',
        'yahoo.com',
        'hotmail.com',
        'mail.ru',
        'protonmail.com',
        'icloud.com'
    ];
begin
    result := result ||
              substring(lower(fname) from 1 for 1) ||
              lower(lname) ||
              (random()*999)::integer ||
              '@' ||
              domains[(random()*array_length(domains, 1))::int];
    return result;
end;
$$ language plpgsql;


create or replace function insert_legal_entities(
    count integer,
    fnames varchar[],
    mnames varchar[],
    lnames varchar[],
    emails varchar[],
    companies_names varchar[]
) returns void as $$
declare
    i integer := 0;
    phone bigint := 0;
    ITin bigint := 0;
begin
    for i in 1..count loop
        phone := (random() * (9999999999 - 9000000000) + 9000000000)::bigint;
        ITin := (random() * (9999999999 - 0) + 0)::bigint;
        insert into customer(type, fname, mname, lname, email, phone, ITin, company_name)
        values ('legal_entity', fnames[i], mnames[i], lnames[i],emails[i], phone, ITin, companies_names[i]);
    end loop;
END
$$ language plpgSQL;

select insert_legal_entities(
    10,
    array['Anatoliy', 'Vyacheslav', 'Yan', 'Konstantin', 'Oleg', 'Pavel', 'Pyotr', 'Fedor', 'Platon', 'Rodion', 'Alexander'],
    array['Aleksandrovich', 'Edouardovich', 'Borisovich', null, null, 'Fedorovich', 'Filippovich', 'Georgiyevich', 'Grigoryevich', null],
    array['Ivanov', 'Smirnov', 'Kuznetsov', 'Popov', 'Vasilyev', 'Petrov', 'Sokolov', 'Mikhaylov', 'Novikov', 'Fedorov'],
    array['zfsseugrvc@gmail.com', 'gztxvgvacj@gmail.com', 'jgqmwjigdr@gmail.com', 'wzdpukvkrm@gmail.com', 'haxsdhokzf@gmail.com', 'rgvxlfzchs@gmail.com', 'zejtpivlls@gmail.com', 'fjetsheccb@gmail.com', 'xgwcrxhslf@gmail.com', 'enhppseqcn@gmail.com'],
    array['CODENETIX', 'inSIGHTWHALE', 'AZOFT', 'FIRST LinE SOFTWARE', 'SHOPDEV', 'Veeam Software', 'Luxoft', 'TeamDev', 'T-Systems CIS', 'ScienceSoft Inc.']
);


create or replace function insert_individuals(
    fnames varchar[],
    mnames varchar[],
    lnames varchar[]
)
returns void as $$
declare
    i integer := 0;
    j integer := 0;
    k integer := 0;
    phone bigint := 0;
begin
    for i in 1..array_length(fnames, 1) loop
        for j in 1..array_length(mnames, 1) loop
            for k in 1..array_length(lnames, 1) loop
                if (random() < 0.4) then continue; end if;

                phone := (random() * (9999999999 - 9000000000) + 9000000000)::bigint;
                insert into customer(type, fname, mname, lname, email, phone)
                values ('individual', fnames[i], mnames[j], lnames[k], get_random_email(fnames[i], lnames[k]), phone)
                on conflict do nothing;
            end loop;
        end loop;
    end loop;

end
$$ language plpgSQL;

-- http://imja.name/familii/pyatsot-chastykh-familij.shtml
select insert_individuals(
    array[
        'Anatoliy', 'Vyacheslav', 'Yan', 'Konstantin', 'Oleg',
        'Pavel', 'Pyotr', 'Fedor', 'Platon', 'Rodion', 'Alexander',
        'David', 'Patrick', 'Renat', 'Timur', 'Vlad', 'Oliver',
        'Suga', 'Jimin', 'Jungkook', 'Denis', 'Efrem', 'Vsevolod',
        'Vadim', 'Boris', 'Avraam', 'Nikita', 'Fedor', 'Joseph', 'German',
        'Ilya', 'Jack', 'Daniil', 'Nikon', 'Igor', 'Kamil', 'Albert'
    ],
    array[
        'Aleksandrovich', 'Edouardovich', 'Borisovich', 'Fedorovich',
        'Filippovich', 'Georgiyevich', 'Grigoryevich', null, 'Daniilovich',
        'Ilevich', 'Avramovich', 'Nikonovich', 'Igorovich', 'Kamilovich',
        'Germanovich', 'Jackovich', 'Timurovich', 'Efremovich', 'Jiminovich'
    ],
    array[
        'Ivanov', 'Smirnov', 'Kuznetsov', 'Popov', 'Vasilyev', 'Petrov',
        'Sokolov', 'Mikhaylov', 'Novikov', 'Mashin', 'Erukhimov', 'Zyryanov',
        'Shestakov', 'Alenkov', 'Kubikov', 'Nekrasov', 'Sokolov', 'Petrov',
        'Ivanov', 'Sidorov', 'Bostrikov', 'Aliev', 'Khokhlov', 'Ivaskevich',
        'Mozalyov', 'Titenko', 'Kosarev', 'Kovalyov', 'Zhasminov', 'Fedorenko',
        'Storozhev', 'Koshelev', 'Chirkunov', 'Shpak', 'Bachirov', 'Vinnichenko',
        'Voronkov', 'Bagramyan', 'Malygin', 'Kesler', 'Voloshkov', 'Efimov',
        'Portnov', 'Einstein', 'Adams', 'Zaytsev', 'Saakyan', 'King', 'Bush',
        'Wolf', 'Belov', 'Night', 'Tsoy', 'Pavlov', 'Defo', 'Mironov', 'Grigoryev',
        'Gachev', 'Maslyakov', 'Leontyev', 'Marks', 'Kozlov', 'Kerry', 'Karter',
        'Block', 'Bogomolov', 'Brown', 'Boyko', 'Bakh', 'Barns', 'Andreev', 'Aliev'
    ]
);

select insert_individuals(
    array['Olivia', 'Emma', 'Ava', 'Sophia', 'Galina', 'Irina', 'Lada', 'Marisha', 'Yelena', 'Ketherina', 'Julia', 'Anastasia', 'Darya', 'Nadezhda', 'Inna', 'Zara', 'Jazzy', 'Maria', 'Olga', 'Anzhelika', 'Veronika', 'Alisa', 'Valentina', 'Polina', 'Arina', 'Sonya'],
    array['Aleksandrovna', 'Edouardovna', 'Borisovna', 'Fedorovna', 'Filippovna', 'Georgiyevna', 'Grigoryevna', null],
    array['Mashina', 'Erukhimova', 'Zyryanova', 'Shestakova', 'Alenkova', 'Kubikova', 'Nekrasova', 'Sokolova', 'Petrova', 'Ivanova', 'Sidorova', 'Bostrikova', 'Alieva', 'Khokhlova', 'Ivaskevich', 'Mozalyova', 'Titenko', 'Kosareva', 'Kovalyova', 'Zhasminova', 'Fedorenko', 'Storozheva', 'Kosheleva', 'Chirkunova', 'Shpak', 'Bachirova', 'Vinnichenko', 'Voronkova', 'Bagramyan', 'Malygina', 'Kesler', 'Voloshkova', 'Efimova', 'Portnova']
);

--------------------------------------------
/**
  * Заполнение таблицы адресов.
  * Принимает кол-во записей в таблицу, массивы с городами и улицами
  * на каждом шаге вычисляет рандомные индексы для массивов
  * городов, улиц и рандомный номер дома
  * и вставляет в таблицу address строки с элементами с
  * рандомными индексами из вышеупомянутых массивов.
 */

create or replace function insert_address(
    entity_count integer,
    city varchar[],
    street varchar[]
)
returns void as $$
declare
    i integer := 0;
    random_city_idx integer := 0;
    random_street_idx integer := 0;
    random_building integer := 0;
begin
    for i in 1..entity_count loop
        random_city_idx := (random() * (array_length(city, 1) - 1) + 1)::integer;
        random_street_idx := (random() * (array_length(street, 1) - 1) + 1)::integer;
        random_building := (random() * (150 - 1) + 1)::integer;
       insert into address(owner_id, country, city, street, building, comment)
       values (i, 'Russian Federation', city[random_city_idx], street[random_street_idx], random_building, '');
    end loop;

END
$$ language plpgSQL;

select insert_address(10, array['Moscow', 'Petrozavodsk', 'Rostov-on-Don', 'Saint Petersburg', 'Tomsk', 'Ufa', 'Yaroslavl', 'Omsk', 'Kaliningrad', 'Kazan'],
    array['Centralnaya, ul.', 'Molodezhnaya, ul.', 'Shkolnaya, ul.', 'Lesnaya, ul.', 'Sovetskaya, ul.', 'Novaya, ul.', 'Sadovaya, ul.', 'Naberezhnaya, ul.', 'Zarechnaya, ul.',
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

do $$
declare
    i integer := 0;
    random_capacity integer := 0;
    trucks_count integer := 20;
begin
    for i in 1..trucks_count loop
       random_capacity := (random() * (150 - 10) + 10)::integer;
       insert into delivery_truck(order_id, capacity, delivery_by)
       values (NULL, random_capacity, NULL);
    end loop;

end
$$ language plpgSQL;

--------------------------------------------
/**
  * Заполнение таблицы связи продуктов и магазинов.
  * Количество товара генерируется рандомно
 */

do $$
declare
    i integer := 0;
    product_id integer := 0;
    store_id integer := 0;
    stores_count integer := 0;
    products_count integer := 0;
begin
    select count(*) from store into stores_count;
    select count(*) from product into products_count;

    for i in 1..stores_count loop
        select id from product order by random() limit 1 into product_id;
        insert into store_item values (i, product_id, random() * 190 + 10) on conflict do nothing;
    end loop;

    for i in 1..products_count loop
        select id from store order by random() limit 1 into store_id;
        insert into store_item values (store_id, i, random() * 190 + 10) on conflict do nothing;
    end loop;

end;
$$ language plpgSQL;

-- -------------------------------------
-- insert cupboard items
do $$
declare
    cupboards_count integer := 0;
    current_max_amount_per_tea real := 0;
    current_tea_amount real := 0;
    current_teas_num integer := 0;
begin
    select count(*) from tea_cupboard into cupboards_count;
    for i in 1..cupboards_count loop
        current_teas_num := 1 + 9*random();
        select coalesce(capacity, 0)/current_teas_num from tea_cupboard into current_max_amount_per_tea;
        if current_max_amount_per_tea = 0 then continue; end if;
        for j in 1..current_teas_num loop
            current_tea_amount := random()*current_max_amount_per_tea;
            insert into cupboard_item values (get_random_tea(), i, current_tea_amount);
        end loop;
    end loop;
end;
$$ language plpgsql;
-- -------------------------------------
-- insert tea_compositions
-- http://www.teausa.com/14656/glossary-of-terms
do $$
begin
    perform create_tea_composition('Wiry', 'A tea leaf which is tightly rolled or twisted, indicative of good withering.');
    perform create_tea_composition('Tisane', 'A term which describes an herbal infusion.');
    perform create_tea_composition('Sumatra', 'Tea grown on the island of Sumatra. Grades and characteristics are similar to Java teas.');
    perform create_tea_composition('Stand-out', 'No surprises here. A tea liquor which is much above average.');
    perform create_tea_composition('Tannin', 'A class of chemicals contained in tea that are thought to be responsible for tea''s health benefits. The contribute heavily to the taste and pungent characteristics of tea.');
    perform create_tea_composition('Thick', 'Describes tea liquor having substance, but not necessarily strength.');
    perform create_tea_composition('Soft', 'A tea which is under fermented (under oxidized).');
    perform create_tea_composition('Silvery Oolong', 'Another costly tea which utilizes the delicate whitish leaf from the first flush.');
    perform create_tea_composition('Pekoe', 'A size of tea leaf characterized by leaves which are shorter and not as wiry as Orange Pekoe. The liquors generally have more color.');
    perform create_tea_composition('Silver Tip Pekoe ', 'A very costly tea from China and Sri Lanka, made from full-grown buds of special cultivars. This is sometimes referred to as White Tea.');
    perform create_tea_composition('Rains', 'Describes liquor of a dull plain tea manufactured during the rainy season.');
    perform create_tea_composition('Organoleptic', 'The process used by most tea tasters to evaluate the quality of a tea using all the senses.');
    perform create_tea_composition('Rich', 'A mellow liquor which is abounding in quality and thickness.');
    perform create_tea_composition('Gone Off', 'Tea which is not good because it is old, mouldy, or otherwise tainted.');
    perform create_tea_composition('Autumnal', 'Describes the liquor from teas grown in Autumn, in cool weather. The term is most often applied to teas from Northern India.');
    perform create_tea_composition('Muddy', 'A term which describes a dull or lifeless liquor.');
    perform create_tea_composition('Mouldy', 'An undesirable trait characterized by a mouldy taste and odor resulting from improper storage.');
    perform create_tea_composition('Gyokuro', 'A prized Japanese Green Tea which is rich in taste and pleasing to the eye. The tea undergoes special handling at every stage of its growth (shaded) and processing (hand-fired).');
    perform create_tea_composition('Bancha', 'A Japanese tea made from coarse leaves, usually from the last plucking. This tea is generally consumed domestically.');
    perform create_tea_composition('Flush', 'The new growth on a tea plant consisting of a full complement of leaves. It takes about 15 - 20 days for bush to flush after plucking.');

end
$$ language plpgsql;