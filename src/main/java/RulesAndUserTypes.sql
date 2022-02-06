/*Пользовательский тип*/

create type t_phone from varchar(12);

create table Directors
(
    id           int         not null,
    first_name   varchar(20) not null,
    last_name    varchar(25) not null,
    phone_number t_phone     not null,
    constraint pk_directors primary key (id),
    constraint unq_directors unique (phone_number)
);

insert into Directors
values (1, 'Семен', 'Батыгин', '+79006662255'),
       (2, 'Александр', 'Парфенов', '+7919456887');
select *
from Directors;


/*Создание правил*/

create rule rule_number as @phone_number like '+7%'

create rule rule_id as @id between 1 and 100

--активация правила
sp_bindrule rule_number, t_phone

sp_bindrule rule_id, 'Directors.id'

--в соответствии с правилами
insert into Directors
values (3, 'German', 'Instons', '+79885553212')

select *
from Directors

--нарушение правила номера телефона
         insert into Directors
values (4, 'German', 'Instons', '+19885553212')

--нарушение правила id
insert into Directors
values (0, 'German', 'Instons', '+78885553212')

--обновление в соответствии с правилами
update Directors
set first_name = 'Anton'
where id = 1;

--нарушение правила номера телефона
update Directors
set phone_number = '+19171883355'
where id = 1;

--нарушение правила id
update Directors
set id=101
where id = 1;


/*Значения по умолчанию*/
create default default_phone as '+79170000000'

--привязываем значение к полю
sp_bindefault default_phone, 'Directors.phone_number'

insert into Directors
values (5, 'Борис', 'Николаевич', default);
select *
from Directors
where first_name = 'Борис';

alter table Directors
    drop constraint unq_directors

update Directors
set phone_number = default
where first_name = 'Александр'

select *
from Directors
