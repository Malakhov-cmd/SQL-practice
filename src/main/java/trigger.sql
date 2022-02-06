/****************  Создать и проверить работу триггера, реализующего сложное правило *****************/

--Запрет поставщику находиться на территории New-Mexico и Arizona
create trigger sourth_state
    on Поставщик
    for update
    as
begin
if
update (адрес) and exists
    (select *
    from inserted
    where адрес like '%New-Mexico%' or адрес like '%Arizona%')
begin
raiserror
    ('Incorrect addres! Close area', 16, 10)
rollback tran
end
end

--Отсутствие конфликта
update Поставщик
set адрес = 'Tomsk, ulibchevya, 147'
where Номер_поставщика = 3
select адрес
from Поставщик
where Номер_поставщика = 3

--Конфликт по закрытой зоне
update Поставщик
set адрес = 'New-Mexico, midlewill, 24'
where Номер_поставщика = 3


/******************** Создать и проверить работу триггера, реализующего сложное значение по умолчанию *******************/

/*В случае отсутствии информации о названии товара при доставке на склад - ввести значение по умолчанию*/
create trigger item_edit
    on Факт_прихода
    for insert, update
    as
begin
update Факт_прихода
set Наименование_товара = 'unknown',
    Количество_прихода  = 0,
    Date_comes          = '1971-01-01',
    Номер_поставщика    = 1
where Номер_накладного_прихода in
      (select Номер_накладного_прихода
       from inserted
       where Наименование_товара is null)
end

--Обычная доставка
insert into Факт_прихода
values (1027, 4, 'Samsung galaxy watch', '2021-02-10', 15)
select *
from Факт_прихода
where Номер_накладного_прихода = 1027

--Доставка, значения атрибутов которой заполнит триггер
insert into Факт_прихода
values (1028, 5, null, '2021-01-01', 10)
select *
from Факт_прихода
where Номер_накладного_прихода = 1028

--Обычное обновление
update Факт_прихода
set Наименование_товара = 'Samsung gear s3'
where Номер_накладного_прихода = 1027
select Наименование_товара
from Факт_прихода
where Номер_накладного_прихода = 1027

--Обновление на значение по умолчанию
update Факт_прихода
set Наименование_товара = null
where Номер_накладного_прихода = 1026
select Номер_накладного_прихода, Наименование_товара, Date_comes
from Факт_прихода
where Номер_накладного_прихода = 1026


/*************** Создать и проверить работу триггера, реализующего уникальность поля, не являющегося первичным ключом *********************/
/*Задание 3*/
/*Проверка уникальности значения атрибута KPP*/
create trigger KKP_uniq
    on Банковские_реквизиты
    for insert, update
    as
begin
if
update (KPP) and
    (select count(br.KPP)
    from Банковские_реквизиты br , inserted ins
    where br.KPP = ins.KPP) > 1
begin
raiserror
    ('Error! KPP must be uniqueu', 16, 10)
rollback tran
end
end

--Обычное обновление
update Банковские_реквизиты
set KPP = 10001
where Код_банковских_реквизитов = 100
select Код_банковских_реквизитов, KPP
from Банковские_реквизиты
where Код_банковских_реквизитов = 100

--Ошибка, данный KPP уже занят
update Банковские_реквизиты
set KPP = 10001
where Код_банковских_реквизитов = 110

--Успешное добавление
insert into Банковские_реквизиты
values (120, 11111, 22222, 33333)


/********************* Создать и проверить работу триггера, реализующего ссылочную целостность restrict. ********************/

/*В случае наличия записи в зависимой таблице, операция удаления и изменения атрибутов главной таблицы не произойдет*/
Create table Items
(
    Наименование_товара varchar(40) primary key,
    количество          int
);

INSERT INTO Items
VALUES ('Play Station 4 standart', 75),
       ('Play Station 4 slim', 35),
       ('Play Station 4 pro', 50),
       ('Play Station 5', 20),
       ('XBOX ONE', 15),
       ('XBOX 360', 5),
       ('XBOX Series X', 30),
       ('Lenovo Legion 5', 80),
       ('Lenovo Legion C7', 7),
       ('Lenovo Legion Y730', 38),
       ('Aser Nitro 5', 18),
       ('Asus TUF	', 1),
       ('HP OMEN 17', 5),
       ('MSI GL75', 7),
       ('MSI SIMMIT', 3),
       ('ASUS ROG', 1);

create trigger dependecy_item_checker
    on Items
    for delete, update
    as
begin
if exists
		(select del.Наименование_товара
			from deleted del join Факт_прихода income
				on del.Наименование_товара = income.Наименование_товара)
	begin
raiserror
('Error! You cant delete or rename item that we have at the toolbase', 16, 10)
rollback tran
end
end

--Ошибка! Такой товар есть на складе
delete
from Items
where Наименование_товара = 'XBOX 360'

--Успешное удаление, по причине отсутствия данного вида товара на складе
insert into Items
values ('SkyDriver', 15)
delete
from Items
where Наименование_товара = 'SkyDriver'

--Ошибка! Такой товар есть на складе под соответствующим названием
update Items
set Наименование_товара = 'GameBoy 90s classics'
where Наименование_товара = 'XBOX 360'

--Успешное обновление, так как такого товара на складе нет
update Items
set Наименование_товара = 'GameBoy 90s classics'
where Наименование_товара = 'Samsung gear s3 frontier'
select *
from Items
where Наименование_товара = 'GameBoy 90s classics'


/*************** Создать и проверить работу триггера, реализующего ссылочную целостность cascade *********************/
/*Изменение значения названия товара в факте прихода*/
create trigger auto_update
    on Items
    for update
    as
begin
update Факт_прихода
set Наименование_товара = (select Наименование_товара from inserted)
where Наименование_товара = (select Наименование_товара from deleted)
end

--Изменение значений
update Items
set Наименование_товара = 'XBOX 1S'
where Наименование_товара = 'XBOX 360'
select Номер_накладного_прихода, Наименование_товара
from Факт_прихода
where Наименование_товара = 'XBOX 1S'
select *
from Items
where Наименование_товара = 'XBOX 1S'

/*Удаление значения в факте прихода при условии его удаления в таблице товаров*/
create trigger auto_delete
    on Items
    for delete
    as
begin
delete
from Факт_прихода
where Наименование_товара = (select Наименование_товара from deleted)
end

delete
from Items
where Наименование_товара = 'Play Station 4 pro'
select Номер_накладного_прихода, Наименование_товара
from Факт_прихода
where Наименование_товара = 'Play Station 4 pro'
select *
from Items
where Наименование_товара = 'Play Station 4 pro'
