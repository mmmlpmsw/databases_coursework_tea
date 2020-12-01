/**
  * функции для использования извне - предполагается, что не для первоначального заполнения
  *
  * to be done:
  * 1) create_order - создает заказ, выбирает любой свободный грузовик(и)
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
    description text
) returns integer as $$
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
    insert into tea_composition(created, name, description)
        values (now(), name, description)
        returning super_id into _composition_id;

    percentage := 1.0/128 + round(random()/2*128)/128;
    insert into composition_item(composition_id, product_id, amount_percent)
        values (_composition_id, get_random_tea(), percentage);
    sum := sum + percentage;

    while sum < 1 loop
        percentage := 1.0/128 + round(random()/2*128)/128;

        if sum + percentage > (1 - 1.0/64) then
            percentage := 1 - sum;
        end if;

        if random() < tea_share then
            insert into composition_item(composition_id, product_id, amount_percent)
                values (_composition_id, get_random_tea(), percentage) on conflict do nothing;
        else
            insert into composition_item(composition_id, product_id, amount_percent)
                values (_composition_id, get_random_product(), percentage) on conflict do nothing;
        end if;

        sum := sum + percentage;
    end loop;
    return _composition_id;
end
$$ language plpgSQL;

create or replace function create_order() returns void as $$
begin
    -- todo
end;
$$ language plpgsql;