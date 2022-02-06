/****************** Создать виды: простой, составной и вид из вида. Отобразить данные из видов.
  Для составного вида переименовать поля и показать некоторые из них. Обосновать особенности
  опции WITH CHECK OPTION при работе с видами. ***********************/


--простой вид
create view view_simple (number_incomer, bank_code, phone_number, addres) as
select *
from Поставщик

select *
from view_simple;

drop view view_simple

--составной вид
create view view_joininig (item_name, date_comes, number_incomer) as
select item.Наименование_товара, income.Date_comes, income.Номер_поставщика
from Товар item
         join Факт_прихода income on item.Наименование_товара = income.Наименование_товара

select *
from view_joininig;

drop view view_joininig

--вид из вида
--номера поставщиков, осуществлявших доставку
create view veiw_combo (number_incomer, incomes) as
select v_1.number_incomer, COUNT(*) as number_incomes
from view_simple v_1
         join view_joininig v_2 on v_1.number_incomer = v_2.number_incomer
group by v_1.number_incomer

select *
from veiw_combo

select incomes as Количество_поставок_поставшиком
from veiw_combo drop view veiw_combo

--WITH CHECK OPTION
create view view_uncheck (item_name, item_number) as
select Наименование_товара, количество
from Товар
where количество > 10

create view view_check (item_name, item_number) as
select Наименование_товара, количество
from Товар
where количество > 10
WITH CHECK OPTION

select *
from view_uncheck

select *
from view_check drop view view_uncheck

drop view view_check

update view_uncheck
set item_number = 5
where item_name = 'Aser Nitro 5'

select *
from view_uncheck update view_check
set item_number = 5 where item_name = 'Aser Nitro 5'

select *
from view_check insert into view_uncheck
values ('Airpad XSS', 1)


