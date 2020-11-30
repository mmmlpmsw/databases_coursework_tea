/**
  * функции для использования извне - предполагается, что не для первоначального заполнения
  *
  * to be done:
  * 1) create_order - создает заказ, выбирает любой свободный грузовик(и)
  * 2) add_tea_to_cupboard
  * 3) выводить содержимое новой композиции
  *
 */

create or replace function get_random_tea() returns integer as
$$
    declare
        result integer := 0;
    begin
        select super_id from tea order by random() limit 1 into result;
        return result;
    end;
$$ language plpgsql;

create or replace function get_random_product() returns integer as
$$
    declare
        result integer := 0;
    begin
        select id from product order by random() limit 1 into result;
        return result;
    end;
$$ language plpgsql;

create or replace function create_tea_composition(
    name varchar,
    description text)
returns integer as $$
declare
    sum real := 0;
    tea_share real := random();
    percentage real := 0;
    _composition_id integer;
begin
/*
    Описание происходящего:
    float sum = 0;
    float tea_share = random();

    float percentage = random()/5;
    add_to_composition(random_tea(), percentage);
    sum += percentage;

    while (sum < 1) {
       float percentage = random()/4;
       if (sum + percentage > 1)
           percentage = 1 - sum;

       add_to_composition(
           random() < tea_share ? random_tea() : random_item(),
           percentage
       );
       sum += percentage;
    }
 */
    insert into tea_composition(created, name, description) values (now(), name, description) returning super_id into _composition_id;

    percentage := round(random()/5*100)/100;
    insert into composition_item(composition_id, product_id, amount_percent) values (_composition_id, get_random_tea(), percentage);
    sum := sum + percentage;

    while sum < 1 loop
        percentage := round(random()/3*100)/100;
        if sum + percentage > 1 then
            percentage := 1 - sum;
        end if;

        if random() < tea_share then
            insert into composition_item(composition_id, product_id, amount_percent) values (_composition_id, get_random_tea(), percentage) on conflict do nothing;
        else
            insert into composition_item(composition_id, product_id, amount_percent) values (_composition_id, get_random_product(), percentage) on conflict do nothing;
        end if;

        select sum(amount_percent) from composition_item where composition_item.composition_id = _composition_id into sum;
    end loop;
    return _composition_id;
end
$$ language plpgSQL;

-- todo delete?
create or replace function get_new_circuit_board_machine(cbmodels_count integer) returns integer as
$$
    declare
        new_machine_id integer := 0;
        i integer := 0;
        random_speed integer := 0;
        employees_count integer := 0;
        employee_id integer := 0;
        circuit_board_model_row circuit_board_model%ROWTYPE;
    begin
        insert into circuit_board_machine(assembly_date, work_hrs, area, state) values (now(), 0, (random() * 100 + 1)::real, 'ok') returning id into new_machine_id;
        for i in 1..cbmodels_count loop
            select id, version into circuit_board_model_row from circuit_board_model order by id limit 1 offset i;
            random_speed := (random() * ( 100 - 10) + 10)::real;
            insert into circuit_board_machine_param_item values (machine_id, circuit_board_model_row.id, circuit_board_model_row.version, random_speed);
        end loop;
        select count(*) from factory_employee into employees_count;
        for i in 1..employees_count loop
            select id from factory_employee order by random() limit 1 into employee_id;
            insert into employee_machine_xref values (employee_id, machine_id) on conflict do nothing;
        end loop;
    end;
$$ language plpgsql;

create or replace function buy_product(_store_id integer, _product_id integer, _amount real) returns void as
$$
declare
    fact_amount real := 0;
begin
    select amount from store_item where store_id = _store_id and product_id = _product_id into fact_amount;
    if (_amount > fact_amount) then
         return;
    else
        update store_item set amount = fact_amount - _amount where store_id = _store_id and product_id = _product_id;
    end if;
end
$$ language plpgsql;
