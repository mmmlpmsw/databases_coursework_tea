create or replace function add_employee(_fname varchar, _mname varchar, _lname varchar) returns int as $$
declare
    i integer := 0;
    employee_id integer := 0;
    machines_count integer := 0;
begin
    select count(*) into machines_count from circuit_board_machine where state = 'ok';
    insert into factory_employee(fname, mname, lname) values (_fname, _mname, _lname) returning id into employee_id;
    for i in 1 .. ((random() * 3 + 1)::int) loop
        insert into employee_machine_xref(employee_id, machine_id)
        values (employee_id, random() * (machines_count - 1) + 1) on conflict do nothing;
    end loop;
    insert into tea_cupboard (owner_id, color, capacity) values (employee_id, hsv_to_rgb(random(), 1, 1), floor(random() * (40 - 10) + 10)::int);
    return employee_id;
end;
$$ language plpgsql;
--------------------------------------------
create or replace function dismiss_employee(_employee_id integer) returns int as
$$
begin
    delete from factory_employee where id = _employee_id;
end;
$$ language plpgsql;
--------------------------------------------
create or replace function add_customer(fname varchar, mname varchar, lname varchar, type customer_type, email varchar,
                                        phone bigint, itin bigint, company_name varchar) returns int as
$$
declare
    customer_id integer := 0;
begin
    insert into customer(type, fname, mname, lname, email, phone, itin, company_name)
    values (type, fname, mname, lname, email, phone, itin, company_name)
    returning id into customer_id;
    return customer_id;
end;
$$ language plpgsql;
--------------------------------------------
create or replace function get_new_circuit_board_machine(cbmodels_count integer) returns integer as $$
declare
    new_machine_id integer := 0;
    i integer := 0;
    random_speed integer := 0;
    employees_count integer := 0;
    employee_id integer := 0;
    circuit_board_model_row circuit_board_model%ROWTYPE;
begin
    insert into circuit_board_machine(assembly_date, work_hrs, area, state)
    values (now(), 0, (random() * 100 + 1)::real, 'ok')
    returning id into new_machine_id;
    for i in 1..cbmodels_count loop
        select id, version into circuit_board_model_row from circuit_board_model order by id limit 1 offset i;
        random_speed := (random() * (100 - 10) + 10)::real;
        insert into circuit_board_machine_param_item
        values (machine_id, circuit_board_model_row.id, circuit_board_model_row.version, random_speed);
    end loop;
    select count(*) from factory_employee into employees_count;
    for i in 1..employees_count loop
        select id from factory_employee order by random() limit 1 into employee_id;
        insert into employee_machine_xref values (employee_id, machine_id) on conflict do nothing;
    end loop;
end;
$$ language plpgsql;
--------------------------------------------
create or replace function buy_product(_store_id integer, _product_id integer, _amount real) returns void as $$
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
--------------------------------------------
create or replace function add_tea_to_cupboard(_tea_id integer, _cupboard_id integer, _amount real) returns bool as $$
declare
    fact_amount real := 0;
    tea_amount_in_cupboard real := 0;
    tea_amount real := null;
begin
    select sum(amount) from cupboard_item where cupboard_id = _cupboard_id into tea_amount_in_cupboard;
    select amount from cupboard_item where cupboard_id = _cupboard_id and product_id = _tea_id into fact_amount;
    if (_amount + tea_amount_in_cupboard > fact_amount) then
        return false;
    else
        select amount from cupboard_item where product_id = _tea_id and cupboard_id = _cupboard_id into tea_amount;
        if tea_amount is null then
            insert into cupboard_item(product_id, cupboard_id, amount) values (_tea_id, _cupboard_id, _amount);
        else
            update cupboard_item
            set amount = _amount + tea_amount
            where cupboard_id = _cupboard_id and product_id = _tea_id;
        end if;
        return true;
    end if;
end
$$ language plpgsql;
--------------------------------------------
create or replace function add_product_to_shop(_product_id integer, _store_id integer, _amount real) returns void as $$
declare
    product_amount real := null;
begin
    select amount into product_amount from store_item where product_id = _product_id and store_id = _store_id;
    if _amount is null then
        insert into store_item(store_id, product_id, amount) values (_store_id, _product_id, _amount);
    else
        update store_item set amount = _amount + product_amount where product_id = _product_id and store_id = _store_id;
    end if;
end
$$ language plpgsql;
--------------------------------------------
create or replace function add_products_to_shop(_product_ids integer[], _store_id integer, _amounts real[]) returns void as $$
declare
    i integer := 0;
begin
    for i in 1 .. array_length(_product_ids, 1) loop
        select add_product_to_shop(_product_ids[i], _store_id, _amounts[i]);
    end loop;
end
$$ language plpgsql;
--------------------------------------------
create or replace function drink_tea(_cupboard_id integer, _tea_id integer, _amount real) returns bool as $$
declare
    i integer := 0;
    tea_amount real := null;
begin
    select amount into tea_amount from cupboard_item where cupboard_id = _cupboard_id and product_id = _tea_id;
    if tea_amount is null or tea_amount - _amount < 0 then
        return false;
    else
        update cupboard_item set amount = tea_amount - _amount  where cupboard_id = _cupboard_id and product_id = _tea_id;
        return true;
    end if;

end
$$ language plpgsql;
--------------------------------------------