-- Adds product entry for new product subclass entries
create or replace function _trigger_add_products_entry() returns trigger as $$
declare
    _id integer := 0;
begin
    insert into product(name) values (TG_ARGV[0]) returning id into _id;
    new.super_id := _id;
    return new;
end;
$$ language plpgSQL;

-- If tea is removed, removes his parent product as well
create or replace function _trigger_delete_super_product() returns trigger as $$
begin
    delete from product where id = old.super_id;
    return new;
end;
$$ language plpgSQL;

-- If amount of store item is 0, delete it
create or replace function _trigger_delete_absent_store_item() returns trigger as $$
begin
    if round(new.amount) = 0 then
        delete from store_item where store_id = new.store_id and product_id = new.product_id;
        return NULL; -- do not execute other triggers
    end if;
    return new;
end;
$$ language plpgSQL;

-- If amount of cupboard item is 0, delete it
create or replace function _trigger_delete_absent_cupboard_item() returns trigger as $$
begin
    if new.amount = 0 then
        delete from cupboard_item where cupboard_id = new.cupboard_id and product_id = new.product_id;
        return NULL; -- do not execute other triggers
    end if;
    return new;
end;
$$ language plpgSQL;

-- When circuit board is created, increases the work hours of the machine that assembled this board
create or replace function _trigger_increase_machine_work_hrs() returns trigger as $$
declare
    machine_speed real = null;
begin
    select speed_items_per_hour from circuit_board_machine_param_item
        where machine_id = new.assembled_by and
              board_model_id = new.model_id and
              board_model_version = new.model_version
    into machine_speed;

    if machine_speed is not null then
        update circuit_board_machine set work_hrs = work_hrs + 1/machine_speed where id = new.assembled_by;
    end if;

    return new;
end;
$$ language plpgsql;

-- Machine breaks with 0.0002*work_hrs probability after each work_hrs update
-- should check with condition random() < new.work_hrs (шоб наверняка)
create or replace function _trigger_consider_machine_breaking() returns trigger as $$
begin
    if random() < 0.0002*work_hrs then
        UPDATE circuit_board_machine SET state = 'broken' where id = new.id;
    end if;
    return new;
end;
$$ language plpgsql;

DROP TRIGGER IF EXISTS add_tea_to_products on tea;
create trigger add_tea_to_products before insert on tea
    for each row execute procedure _trigger_add_products_entry('Tea');

DROP TRIGGER IF EXISTS add_tea_composition_to_products on tea_composition;
create trigger add_tea_composition_to_products before insert on tea_composition
    for each row execute procedure _trigger_add_products_entry('Tea Composition');

DROP TRIGGER IF EXISTS delete_tea_from_products on tea;
create trigger delete_tea_from_products after delete on tea
    for each row execute procedure _trigger_delete_super_product();

DROP TRIGGER IF EXISTS delete_tea_composition_from_products on tea_composition;
create trigger delete_tea_composition_from_products after delete on tea_composition
    for each row execute procedure _trigger_delete_super_product();

DROP TRIGGER IF EXISTS delete_absent_store_item on store_item;
create trigger delete_absent_store_item after update on store_item
    for each row execute procedure _trigger_delete_absent_store_item();

DROP TRIGGER IF EXISTS delete_absent_cupboard_item on cupboard_item;
create trigger delete_absent_cupboard_item after update on cupboard_item
    for each row execute procedure _trigger_delete_absent_cupboard_item();

DROP TRIGGER IF EXISTS increase_machine_work_hrs on circuit_board;
create trigger increase_machine_work_hrs after insert on circuit_board
    for each row execute procedure _trigger_increase_machine_work_hrs();

DROP TRIGGER IF EXISTS consider_machine_breaking on circuit_board_machine;
create trigger consider_machine_breaking after update of work_hrs on circuit_board_machine
    for each row execute procedure _trigger_consider_machine_breaking();