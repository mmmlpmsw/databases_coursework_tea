-- Adds product entry for new product subclass entries
create or replace function _trigger_add_products_entry() returns trigger as $$
declare
    _id integer := 0;
begin
    insert into product(name) values (TG_ARGV[0]) returning id into _id;
    NEW.super_id := _id;
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

create trigger add_tea_to_products before insert on tea
    for each row execute procedure _trigger_add_products_entry('Tea');

create trigger add_tea_composition_to_products before insert on tea_composition
    for each row execute procedure _trigger_add_products_entry('Tea Composition');

create trigger delete_tea_from_products after delete on tea
    for each row execute procedure _trigger_delete_super_product();

create trigger delete_tea_composition_from_products after delete on tea_composition
    for each row execute procedure _trigger_delete_super_product();