/*************	Создать и вызвать хранимую процедуру без параметров *************/

/*Задание №1
  Обновиться значение столбца количества поставок у поставщика*/

create procedure updateIncomes
as
begin
declare cur cursor scroll dynamic
    for
select Номер_поставщика,
       (select count(*)
        from Факт_прихода
        where Факт_прихода.Номер_поставщика = Поставщик.Номер_поставщика) as Количество_поставок
from Поставщик;

open cur

	declare
@number_incomer int
	declare
@count_income int

fetch first from cur into @number_incomer, @count_income
		while @@FETCH_STATUS =0
begin
update Поставщик
set count_incomes = @count_income
where Номер_поставщика = @number_incomer
fetch next from cur into @number_incomer, @count_income
end
close cur
deallocate cur
end

alter table Поставщик
    add count_incomes int not null default 0;

execute updateIncomes

/****************** Создать и вызвать хранимую процедуру с входным, выходным формальным параметром
  и входным параметром, имеющим значение по умолчанию. Реализовать вызов процедуры, используя
  позиционный, ключевой, смешанный виды передачи параметров. ******************/

/*Возвращает поставщика по заданным параметрам*/
create procedure multy(@bank_code int = 100, @address varchar (40) = 'Moscow, Pushkinskaya, 74a', @id int, @number int output)
as
set @number = (select count_incomes from Поставщик where Код_банковских_реквизитов = @bank_code and адрес = @address and Номер_поставщика = @id)
    return

declare
@NumberIncomer int

execute multy @bank_code = 103, @address = 'Samara, Moscowskoe, 15', @id = 4 , @number = @NumberIncomer output
print 'Incomer: ' + convert(varchar(2),@NumberIncomer)

execute multy default, default, @id = 1, @number = @NumberIncomer output
print 'Incomer: ' + convert(varchar(2),@NumberIncomer)

execute multy default, default, @id = 1, @number = @NumberIncomer output
print 'Incomer: ' + convert(varchar(2),@NumberIncomer)

execute multy default, 'Samara, Moscowskoe, 15', 4, @number = @NumberIncomer output
print 'Incomer: ' + convert(varchar(2),@NumberIncomer)


/********** Создать и вызвать скалярную хранимую функцию. **************/
/*Возвращает количество видов поставляемых компанией*/
create function countCompanyItem(@compName varchar (40))
    returns int
as
begin
return
(select count(Наименование_товара) from Товар where Наименование_товара like @compName + '%')
end

select 'Count Play Station type: ' = dbo.countCompanyItem('Play Station')


/******************** Создать и вызвать функцию, возвращающую табличное значение. ************************/
/*Возвращает полную информацию о поставщике(ах) занимающихся поставками товара заданного бренда*/
create function getInfoCompanyIncomerIncomer(@comp_name varchar (40) = 'Play Station')
    returns
table as
return
select Номер_поставщика, Код_банковских_реквизитов, телефон, адрес
from Поставщик
where Номер_поставщика in
      (select Номер_поставщика
       from Факт_прихода
       where Наименование_товара
                 like @comp_name + '%')


select *
from dbo.getInfoCompanyIncomerIncomer('Play Station')


/****************** Создать и вызвать процедуру, возвращающую курсор, продемонстрировать содержимое курсора. **************/
/*Создание и зополнение курсора данными о поставщиках и количестве их поставок*/
create procedure get_cursor
    @ Cursor Cursor varying output
AS
Set @ Cursor = cursor dynamic for select
    Номер_поставщика,
    (select count(*)
    from Факт_прихода
    where Факт_прихода.Номер_поставщика = Поставщик.Номер_поставщика) as Количество_поставок
    from Поставщик;
Open @Cursor
return

declare
@Curs cursor
Exec get_cursor @Cursor = @Curs output
fetch first from @Curs
    while @@FETCH_STATUS = 0
begin
fetch next from @Curs
end
close @Curs
