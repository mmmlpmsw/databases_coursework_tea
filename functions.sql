/**
  * функции для использования извне - предполагается, что не для первоначального заполнения
  *
  * to be done: (желательно по мере выполнения переносить их из 'to be done' в готовые)
  * 1) create_tea_composition - создает чайную композицию, автоматически выбирает нужные ингредиенты
  * 2) create_order - создает заказ, выбирает любой свободный грузовик(и)
  * 3) update_circuit_board_machine - покупает новую машину для печатных плат, чтобы заменить старые
  * ??????????? 4) (как вариант использования) buy_product - купить товар(-ы) в магазине (зачем? - см.отчет)
  *
 */

CREATE OR REPLACE FUNCTION create_tea_composition(name varchar, description text) RETURNS VOID AS
$$
DECLARE
    sum real := 0;
    tea_share real := random();
    percentage integer := 0;
    composition_id integer;
BEGIN
/*
 float sum = 0;
 float tea_share = random();

 float percentage = random()/5;
 add_to_composition(random_tea(), percentage);
 sum += percentage;

 while (sum < 1) {
    float percentage = random()/4;
    add_to_composition(
        random() < tea_share ? random_tea() : random_item(),
        percentage
    );
    sum += percentage;
 }
 */
    start transaction;
    insert into tea_composition(created, name, description) values (now(), name, description) returning super_id into composition_id;

    percentage := random()/5;

    commit;
END
$$ LANGUAGE plpgSQL;