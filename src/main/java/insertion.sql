INSERT INTO Банковские_реквизиты
VALUES (101, 15987, 79845, 46452),
       (102, 47895, 78956, 46564),
       (103, 15963, 14782, 46739),
       (104, 98235, 78952, 46785),
       (105, 78214, 78254, 46785),
       (106, 15974, 45632, 46746),
       (107, 36951, 78941, 46963),
       (108, 31975, 47823, 46548),
       (109, 78952, 12354, 46874);
INSERT INTO Поставщик
VALUES (1, 100, +79851476985, 'Moscow, Pushkinskaya, 74a'),
       (2, 101, +79171682255, 'Samara, Leningradskaya, 15a'),
       (3, 102, +79874567896, 'Omsk, Toska, 158'),
       (4, 103, +79172225588, 'Chelyabinsk, Medovaya, 1/8b');

INSERT INTO Банковские_реквизиты
VALUES (110, 15658, 78563, 78952),
       (111, 75961, 74965, 74123),
       (112, 15658, 78563, 78952),
       (113, 75961, 74965, 74123);


INSERT INTO Поставщик
VALUES (5, 110, +79874567896, 'Paris, Le Duel, 1/15'),
       (6, 111, +79172225588, 'Gamburg, Lihtshtrasse, 76'),

       (7, 111, +79172225588, 'Voronesh, Kirova, 17'),
       (8, 111, +79172225588, 'Voronesh, Kirova, 17'),


       (9, 120, +79172225588, 'Kirov, Kirova, 17'),
       (10, 121, +79172225588, 'Kirov, Kirova, 17');

INSERT INTO Факт_прихода
VALUES (1026, 5, 'Lenovo Legion Y730', '2021-02-13', 3),
       (1025, 6, 'Play Station 4 standart', '2021-01-13', 40),
       (1024, 1, 'Lenovo Legion Y730', '2021-02-15', 3),
       (1025, 1, 'Play Station 4 standart', '2021-01-20', 40);

INSERT INTO Получатель
VALUES (1, 104, +79478562452, 'Moscow, Myasnitskiy, 69'),
       (2, 105, +79856321478, 'Samara, Moscowskoe, 151'),
       (3, 106, +79898563741, 'Samara, Novosadovaya, 215'),
       (4, 107, +19789632145, 'New York, Bright, 146/3'),
       (5, 108, +19863145279, 'Ostin, Righter, 17'),
       (6, 109, +19159356786, 'San Diego, Pillslow, 1');

INSERT INTO Товар
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

INSERT INTO Факт_расхода
VALUES (1000, 1, 'Play Station 4 standart', '2021-01-03', 15),
       (1001, 1, 'Play Station 4 slim', '2021-01-04', 40),
       (1002, 1, 'Play Station 4 pro', '2021-01-05', 50),
       (1003, 2, 'XBOX 360', '2021-01-06', 10),
       (1004, 2, 'XBOX ONE', '2021-01-13', 25),
       (1005, 2, 'MSI SIMMIT', '2021-01-03', 3),
       (1006, 3, 'MSI SIMMIT', '2021-01-15', 4),
       (1007, 3, 'MSI GL75', '2021-01-13', 3),
       (1008, 4, 'Aser Nitro 5', '2021-01-19', 2),
       (1009, 4, 'ASUS ROG', '2021-01-15', 4),
       (1010, 4, 'Asus TUF	', '2021-02-07', 4),
       (1011, 4, 'HP OMEN 17', '2021-01-25', 5),
       (1012, 4, 'Lenovo Legion 5', '2021-01-30', 20),
       (1013, 5, 'Lenovo Legion C7', '2021-01-29', 3),
       (1014, 5, 'Lenovo Legion Y730', '2021-02-15', 2),
       (1015, 5, 'MSI GL75', '2021-01-14', 15),
       (1016, 6, 'Aser Nitro 5', '2021-01-21', 10),
       (1017, 6, 'ASUS ROG', '2021-02-17', 15),
       (1018, 6, 'Asus TUF	', '2021-02-08', 10),
       (1019, 2, 'HP OMEN 17', '2021-01-29', 10),
       (1020, 2, 'Lenovo Legion 5', '2021-02-01', 10),
       (1021, 3, 'Lenovo Legion C7', '2021-02-05', 10),
       (1022, 1, 'Lenovo Legion Y730', '2021-02-17', 20),
       (1023, 1, 'Play Station 4 standart', '2021-02-14', 55),
       (1024, 1, 'Play Station 4 standart', '2021-01-08', 75),
       (1015, 3, 'MSI GL75', '2021-01-10', 15),
       (1016, 4, 'Aser Nitro 5', '2021-01-20', 10),
       (1017, 4, 'ASUS ROG', '2021-02-14', 15),
       (1018, 4, 'Asus TUF	', '2021-02-07', 10),
       (1019, 4, 'HP OMEN 17', '2021-01-27', 15),
       (1020, 4, 'Lenovo Legion 5', '2021-01-30', 10),
       (1023, 1, 'Play Station 4 standart', '2021-02-13', 40),
       (1021, 4, 'Lenovo Legion C7', '2021-01-27', 10),
       (1022, 4, 'Lenovo Legion Y730', '2021-02-13', 20)
