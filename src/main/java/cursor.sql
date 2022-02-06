/*Динамический курсор*/
--Создание курсора
declare cursor_dynamic cursor dynamic scroll

--Заполнение курсора
    for
select Номер_поставщика, Наименование_товара, Date_comes
from Факт_прихода
where CHARINDEX('Play Station', Наименование_товара) <> 0
order by 1
    for update

--Открытие курсора
    open cursor_dynamic

--Объявление переменных для работы
declare
@dNumber_incomer int,
		@dName_item varchar(40),
		@dDate_comes date

--Заполнение объявленных переменных первой строкой курсора
Fetch first from cursor_dynamic into @dNumber_incomer, @dName_item, @dDate_comes

--Вывод всех записей курсора
while @@FETCH_STATUS = 0
begin
select [Num_incomer] =@ dNumber_incomer,
       [Name] =@ dName_item,
       [Date] =@ dDate_comes fetch next
from cursor_dynamic
into @dNumber_incomer, @dName_item, @dDate_comes
end

update Факт_прихода
set Date_comes = '2021-01-20'
where Наименование_товара = 'Play Station 4 pro'
  and Номер_поставщика = 3

--Закрытие курсора
close cursor_dynamic

--Уничтожение курсора
deallocate cursor_dynamic

/********************* Вывод: динамический курсов в tempdb хранит ссылки на записи, поэтому при изменении
  записей на которые ссылается курсор происходит отображение изменений при открытом курсоре **************************/

/*Статический курсор*/
--Создание курсора
declare cursor_static cursor scroll static

--Заполнение курсора
    for
select Номер_поставщика, Наименование_товара, Date_comes
from Факт_прихода
where CHARINDEX('Play Station', Наименование_товара) <> 0
order by 1

--Открытие курсора
    open cursor_static

--Объявление переменных для работы
declare
@sNumber_incomer int,
		@sName_item varchar(40),
		@sDate_comes date

--Заполнение объявленных переменных первой строкой курсора
Fetch first from cursor_static into @sNumber_incomer, @sName_item, @sDate_comes

--Вывод всех записей курсора
while @@FETCH_STATUS = 0
begin
select [Num_incomer] =@ sNumber_incomer,
       [Name] =@ sName_item,
       [Date] =@ sDate_comes fetch next
from cursor_static
into @sNumber_incomer, @sName_item, @sDate_comes
end

update Факт_прихода
set Date_comes = '2021-01-20'
where Наименование_товара = 'Play Station 4 pro'
  and Номер_поставщика = 3

--Закрытие курсора
close cursor_static

--Уничтожение курсора
deallocate cursor_static

/********************* Вывод: Обновления значения не произошло, потому что статический курсор
  изолирован от изменений данных и является неизменяемым. Весь набор данных курсор приобретает
  при первой выборке, сохраняя их слепок. **************************/

/*Ключевой курсор*/
--Товаров, которые не приходят и не расходуются
insert into Товар
values ('Mi 8', 0),
       ('Mi 9', 0),
       ('Mi 10', 0)

--Создание курсора
declare cursor_keyset cursor scroll keyset

--Заполнение курсора
    for
select Наименование_товара, количество
from Товар

--Открытие курсора
         open cursor_keyset

--Объявление переменных для работы
declare
@kName_item varchar(40),
		@kCount_item int

--Заполнение объявленных переменных первой строкой курсора
fetch first from cursor_keyset into @kName_item, @kCount_item

--Вывод всех записей курсора
while @@FETCH_STATUS = 0
begin
select [Name_item] =@ kName_item,
       [Count_item] =@ kCount_item fetch next
from cursor_keyset
into @kName_item, @kCount_item
end

update Товар
set количество = 10
where Наименование_товара = 'Mi 8'

update Товар
set Наименование_товара = 'Huawey M3'
where Наименование_товара = 'Mi 8'
--Закрытие курсора
close cursor_keyset

--Уничтожение курсора
deallocate cursor_keyset


/*****************    Вывод: Ключевой курсор отображает изменения не ключевых полей, так как он хранит
  значения ключей и ссылки на записи с данным значением ключа. Если происходит обновление ключа,
  то так как ключ - это упорядоченный список, будет выведен список до изменяемого ключа, сам ключ и изменения
  после него не отображаются, потому что при изменении ключевого поля связь в связном списке нарушается
  и связь с последующими после ключевого поля теряется.**********************/


/**************** Используя динамический курсор, сделать изменения и удаления записей в базе данных. **********************/
fetch first from cursor_dynamic
update Факт_прихода
set Date_comes = '2021-03-20'
where current of cursor_dynamic

fetch first from cursor_dynamic
delete
from Факт_прихода
where current of cursor_dynamic
