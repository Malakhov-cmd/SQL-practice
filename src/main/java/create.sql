Create table Банковские_реквизиты
(
    Код_банковских_реквизитов int primary key,
    BIC                       int,
    INN                       int,
    KPP                       int
);

Create table Поставщик
(
    Номер_поставщика          int primary key,
    Код_банковских_реквизитов int references Банковские_реквизиты (Код_банковских_реквизитов),
    телефон                   varchar(12),
    адрес                     varchar(75)
);

Create table Получатель
(
    Номер_получателя          int primary key,
    Код_банковских_реквизитов int references Банковские_реквизиты (Код_банковских_реквизитов),
    телефон                   varchar(12),
    адрес                     varchar(75)
);

Create table Товар
(
    Наименование_товара varchar(40) primary key,
    количество          int
);

Create table Факт_прихода
(
    Номер_накладного_прихода int primary key,
    Номер_поставщика         int,
    Наименование_товара      varchar(40),
    Дата_поступления         date,
    Количество_прихода       int,
    Constraint FK_Факт_прихода_1 Foreign Key (Наименование_товара) references Товар (Наименование_товара),
    Constraint FK_Факт_прихода_2 Foreign Key (Номер_поставщика) references Поставщик (Номер_поставщика),
    Constraint AK_Uniq Unique (Номер_поставщика, Наименование_товара, Дата_поступления)
);

Create table Факт_расхода
(
    Номер_накладного_расхода int primary key,
    Номер_получателя         int,
    Наименование_товара      varchar(40),
    Дата_расхода             date,
    Количество_расхода       int,
    Constraint FK_Факт_расхода_1 Foreign Key (Наименование_товара) references Товар (Наименование_товара),
    Constraint FK_Факт_расхода_2 Foreign Key (Номер_получателя) references Получатель (Номер_получателя),
    Constraint AK_Uniq_2 Unique (Номер_получателя, Наименование_товара, Дата_расхода)
);

