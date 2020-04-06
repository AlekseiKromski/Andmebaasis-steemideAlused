--Данный файл представляет возможости пользователя admin_doms

USE apartmentPartnership

--Показ основных функций базы данных

--Процедура для добавления нового показания счетчика
	--1. Коль-во MWH 
	--2. Дата, когда ввели данные
EXEC addCounter '2','2020-02-16'

--Процедура для расчета счета по каждой квартире
--Процедура сама берет все нужные для ее работы данные и добавляет их в таблицу. В конце работы процедуры выводиться та самая таблица
--Вместе с данной процедурой срабатывает триггер на добавление новых записей. Триггер вставляет данные в отделную таблицу историй
EXEC houseBill

--##############################################

--Показ работы функций

--Функция выводи информацию об владельце по его isikukood
SELECT * FROM ownerInfo('50208302215')

--Функция выводи информацию об квартире владельца по его isikukood
SELECT * FROM apartmentInfoByOwner('50208302215')

--Функция выводи информацию об счетах владельца по его isikukood
SELECT * FROM houseBullByOwner('50209232215')

--##############################################

--Показ представлений

--Выводит всю доступную информацию о всех пользоватклях
SELECT * FROM allInfoAboutOwner

--Вставка данных
INSERT INTO owners VALUES
	(50208309215,'Aleksei','Kromski','+37259433588','aleksei.kromski@ivkhk.ee')

--apartmentInfo insert
INSERT INTO apartmentInfo VALUES
	(11,60.0,DEFAULT,DEFAULT,'50208309215')

--tariff insert
INSERT INTO tariff (tariffDate,tariffPrice) VALUES
	('2019-12-15',66.26)

--##############################################
--Запросы для просмотра базы данных
SELECT * FROM owners
SELECT * FROM apartmentInfo
SELECT * FROM tariff
SELECT * FROM counter
SELECT * FROM paymentApartment
SELECT * FROM houseBillHistory
SELECT * FROM ownerHistory
SELECT * FROM apartmentInfoHistory

