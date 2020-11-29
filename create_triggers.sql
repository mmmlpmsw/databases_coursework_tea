create or replace function add_tea_to_products() returns trigger as
$$
declare
    _id integer := 0;
begin
    insert into product(name) values ('Tea') returning id into _id;
    NEW.super_id := _id;
    return new;
end;
$$ language plpgSQL;

create trigger add_tea_to_products
    before insert on tea
    for each row
    execute procedure add_tea_to_products();

create or replace function delete_product() returns trigger as
$$
begin
    delete from product where id = old.super_id;
    return old;
end;
$$ language plpgSQL;

create trigger delete_tea_from_products
    after delete on tea
    for each row
    execute procedure delete_product(super_id);

create or replace function add_tea_composition_to_products() returns trigger as
$$
declare
    _id integer := 0;
begin
    insert into product(name) values ('Tea Composition') returning id into _id;
    NEW.super_id := _id;
    return new;
end;
$$ language plpgSQL;

create trigger add_tea_composition_to_products
    before insert on tea_composition
    for each row
    execute procedure add_tea_composition_to_products();

create trigger delete_tea_composition_from_products
    after delete on tea_composition
    for each row
    execute procedure delete_product(super_id);