/**
  * функции для использования извне - предполагается, что не для первоначального заполнения
  *
  * to be done:
  * 1) create_order - создает заказ, выбирает любой свободный грузовик(и)
  * 2) update_circuit_board_machine - покупает новую машину для печатных плат, чтобы заменить старые
  * ??????????? 3) (как вариант использования) buy_product - купить товар(-ы) в магазине (зачем? - см.отчет)
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

create or replace function get_new_circuit_board_machine() returns integer as
$$
    begin
        -- todo добавить новую машину, подключить random(1..n) сотрудников
    end;
$$ language plpgsql;