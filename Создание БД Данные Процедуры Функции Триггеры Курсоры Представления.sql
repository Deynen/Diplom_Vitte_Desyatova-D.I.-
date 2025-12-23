mysql -u root -p

CREATE DATABASE IF NOT EXISTS `orderclient` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;


use orderclient






CREATE TABLE category
(
	idcategory  integer  AUTO_INCREMENT,
	category  varchar(40)  NULL ,
	 PRIMARY KEY (idcategory)
)
;


CREATE TABLE producer
(
	idproducer  integer  AUTO_INCREMENT,
	producer  varchar(40)  NULL ,
	 PRIMARY KEY (idproducer)
)
;


CREATE TABLE merchandise
(
	idmerchandise  integer  AUTO_INCREMENT,
	idcategory  integer  NOT NULL ,
	merchandise  varchar(40)  NULL ,
	price  integer  NULL ,
	annotation  varchar(400)  NULL ,
	idproducer  integer  NOT NULL ,
	 PRIMARY KEY (idmerchandise),
	 FOREIGN KEY (idcategory) REFERENCES category(idcategory)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
 FOREIGN KEY (idproducer) REFERENCES producer(idproducer)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)
;


CREATE TABLE customer
(
	idcustomer  integer   AUTO_INCREMENT,
	customer  varchar(40)  NULL ,
	phone  varchar(40)  NULL ,
	mail  varchar(40)  NULL ,
	address  varchar(40)  NULL ,
	bankaccount  varchar(40)  NULL ,
	 PRIMARY KEY (idcustomer)
)
;


CREATE TABLE ordercustomer
(
	idordercustomer  integer   AUTO_INCREMENT,
	idcustomer  integer  NOT NULL ,
	statusordercustomer  varchar(40)  NULL ,
	statuspay  varchar(40)  NULL ,
	sumordercustomer  integer  NULL ,
	dateordercustomer  datetime  NULL ,
	datedelivery  datetime  NULL ,
	 PRIMARY KEY (idordercustomer),
	 FOREIGN KEY (idcustomer) REFERENCES customer(idcustomer)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)
;


CREATE TABLE ordercustomermerchandise
(
	idordercustomermerchandise  integer   AUTO_INCREMENT,
	idordercustomer  integer  NOT NULL ,
	idmerchandise  integer  NOT NULL ,
	countmerch  integer  NULL ,
	 PRIMARY KEY (idordercustomermerchandise),
	 FOREIGN KEY (idmerchandise) REFERENCES merchandise(idmerchandise)
		ON DELETE CASCADE
		ON UPDATE CASCADE,
 FOREIGN KEY (idordercustomer) REFERENCES ordercustomer(idordercustomer)
		ON DELETE CASCADE
		ON UPDATE CASCADE
)
;











INSERT INTO `category` (`idcategory`, `category`) VALUES
(1, 'Посудомоечные  машины'),
(2, 'Кухонные плиты'),
(3, 'Стиральные машины'),
(4, 'Пылесосы'),
(5, 'Утюги');


INSERT INTO `customer` (`idcustomer`, `customer`, `phone`, `mail`, `address`, `bankaccount`) VALUES
(1, 'Петрова ПС', '89754564522', 'jfh@ya.ru', 'ул. Мира 6', '233445'),
(2, 'Витальев ИА', '89754789142', 'rty@ya.ru', 'ул. Ленина 6', '664433'),
(3, 'Серегин ИА', '89754564742', 'fsdf@ya.ru', 'ул. Кирова 14', '776655'),
(4, 'Протасов ИА', '897545511442', 'hfgh@ya.ru', 'ул. Попова 44', '112233'),
(5, 'Протасова ИА', '89754789887', 'rthhgy@ya.ru', 'ул. Попова 6', '661133');



INSERT INTO `producer` (`idproducer`, `producer`) VALUES
(1, 'BRAUN'),
(2, 'TEFAL'),
(3, 'DYSON'),
(4, 'SAMSUNG'),
(5, 'POLARIS'),
(6, 'LG');

INSERT INTO `merchandise` (`idmerchandise`, `idcategory`, `merchandise`, `price`, `annotation`, `idproducer`) VALUES
(8, 5, 'BRAUN TexStyle 770', 10000, 'Система увлажнения Подача пара: Есть Паровой удар: 120 г/мин Резервуар для воды: 400 мл Функции Спрей: Есть Вертикальное отпаривание: Есть Безопасность Автоматическое отключение: Есть Шнур Шарнирное крепление шнура: Есть Питание Потребляемая мощность: 2400 Вт Цвет: серый ', 1),
(9, 5, 'TEFAL FV 5333', 12000, 'Система увлажнения  Подача пара: Есть  Паровой удар: 130 г/мин  Резервуар для воды: 300 мл  Функции  Спрей: Есть  Вертикальное отпаривание: Есть  Питание  Потребляемая мощность: 2400 Вт  Цвет: Бордовый  ', 2),
(10, 5, 'TEFAL FV 9640', 12000, 'Система увлажнения  Подача пара: Есть  Паровой удар: 200 г/мин  Резервуар для воды: 350 мл  Функции  Спрей: Есть  Вертикальное отпаривание: Есть  Безопасность  Автоматическое отключение: Есть  Шнур  Шарнирное крепление шнура: Есть  Питание  Потребляемая мощность: 2600 Вт  Цвет: Фиолетовый  ', 2),
(11, 4, 'DYSON DC42', 14000, 'Общие Тип: Вертикальный Управление Тип управления: Электронный Сбор пыли Тип пылесборника: Циклонный фильтр Фильтры Фильтр тонкой очистки: HEPA Электропитание Тип электропитания: Сеть 220 В Максимальная потребляемая мощность: 1100 Вт Габариты и вес Вес: 6.7 кг Цвет: Синий, Серебристый ', 3),
(12, 4, 'SAMSUNG VCDC20DV', 30000, 'Общие  Тип: Стандартный  Сбор пыли  Тип пылесборника: Циклонный фильтр  Фильтры  Фильтр тонкой очистки: HEPA11  Электропитание  Тип электропитания: Сеть 220 В  Максимальная потребляемая мощность: 2000 Вт  Габариты и вес  Вес: 4.6 кг  Цвет: Голубой  ', 4),
(13, 4, 'POLARIS PVCR 0726W', 20000, 'Общие  Тип: Робот-пылесос  Управление  Тип управления: Электронный  Фильтры  Фильтр тонкой очистки: HEPA12  Электропитание  Тип электропитания: Аккумулятор  Габариты и вес  Вес: 3.33 кг  Цвет: Золотистый  ', 5),
(14, 3, 'LG FH495BDS2', 20000, 'Общие  Класс стирки: A  Класс отжима: A  Тип управления: Электронный  Прямой привод двигателя: Есть  Загрузка  Максимальная загрузка: 12 кг  Отжим  Максимальная скорость отжима: 1400 об/мин  Функции  Fuzzy Logic: Есть  Барабан  Пузырьковый барабан: Есть  Индикация  Дисплей: Есть  Энергопотребление  Класс энергопотребления: A  Габариты и вес  Высота: 85 см  Ширина: 60 см  Глубина: 64 см  Цвет: Белы', 6),
(15, 3, 'LG F12U2HDM1N', 12000, 'Общие  Класс стирки: A  Класс отжима: B  Тип управления: Электронный  Прямой привод двигателя: Есть  Загрузка  Максимальная загрузка: 7 кг  Максимальная загрузка при сушке: 4 кг  Отжим  Максимальная скорость отжима: 1200 об/мин  Сушка  Встроенная сушка: Есть  Барабан  Пузырьковый барабан: Есть  Индикация  Дисплей: Есть  Энергопотребление  Класс энергопотребления: B  Габариты и вес  Высота: 85 см  ', 6);



INSERT INTO `ordercustomer` (`idordercustomer`, `idcustomer`, `statusordercustomer`, `statuspay`, `sumordercustomer`, `dateordercustomer`, `datedelivery`) VALUES
(1, 1, 'Не выполнено', 'Оплачено', 4700, '2024-11-25 12:36:38', NULL),
(2, 1, 'Выполнено', 'Оплачено', 22500, '2024-11-20 13:26:38', NULL),
(3, 1, 'Выполнено', 'Нет оплаты', 8950, '2024-11-21 14:16:38', NULL),
(4, 1, 'Выполнено', 'Нет оплаты', 8840, '2024-11-22 12:26:38', NULL),
(10, 1, 'Выполнено', 'Оплачено', 0, '2024-11-05 16:41:34', NULL),
(11, 1, 'Не выполнено', 'Оплачено', 4700, '2024-11-25 12:36:38', NULL),
(12, 1, 'Отменено', 'Оплачено', 4700, '2024-11-25 12:36:38', NULL);



INSERT INTO `ordercustomermerchandise` (`idordercustomermerchandise`, `idordercustomer`, `idmerchandise`, `countmerch`) VALUES
(1, 2, 9, 2),
(2, 3, 8, 2),
(3, 1, 10, 4),
(4, 4, 11, 2),
(5, 11, 8, 5),
(6, 1, 15, 6),
(7, 10, 8, 1),
(8, 1, 14, 6);


Выполнять в командной строке впереди и отдельно от скрипта создания процедуры
DELIMITER //





CREATE FUNCTION MaxPriceMerchandise ()
RETURNS  int
BEGIN
DECLARE maxprice int;
SET maxprice=(SELECT MAX(price) FROM merchandise);
	RETURN maxprice;
END//



CREATE FUNCTION CountOrderClient ()
RETURNS  int
BEGIN
DECLARE CountOrder int;
SET CountOrder=(SELECT COUNT(idordercustomer) FROM ordercustomer WHERE statusordercustomer like 'Выполнено' and statuspay like 'Оплачено' and YEAR(dateordercustomer)=YEAR(NOW()));
	RETURN CountOrder;
END//





CREATE FUNCTION PriceUp ()
RETURNS  int
BEGIN
update merchandise set price = ROUND(price + price*0.2);
	RETURN 1;
END//



CREATE PROCEDURE CountMerchandise ( IN idorderIN INT, OUT countorderOUT INT)
BEGIN
SET countorderOUT=(select SUM(countmerch) from ordercustomermerchandise where idordercustomer=idorderIN);
END//



CREATE PROCEDURE InsertOrder(IN idcustomerIN INT)
BEGIN
insert into ordercustomer (idcustomer, statusordercustomer, statuspay, dateordercustomer, sumordercustomer) values (idcustomerIN, 'Не выполнено', 'Нет оплаты', NOW(), 0);
END//



CREATE PROCEDURE FindCustomer ( IN fioIN varchar(40), OUT result varchar(40))
BEGIN
DECLARE CountCustomer int;
SET CountCustomer=(select COUNT(idcustomer) from customer where UPPER(customer) like UPPER(CONCAT('%',fioIN,'%')));
IF (CountCustomer>0)
THEN
SET result=CONVERT(CountCustomer,char);
ELSE
SET result='Покупатель не найден';
END IF;
END//





 
CREATE TRIGGER OrderAfterInsert AFTER INSERT ON ordercustomermerchandise
for each row
begin
declare newsumsale INT default 0;
set newsumsale = (select SUM(countmerch*merchandise.price) from ordercustomermerchandise,merchandise where idordercustomer=new.idordercustomer and ordercustomermerchandise.idmerchandise=merchandise.idmerchandise);
update ordercustomer set sumordercustomer=newsumsale where idordercustomer=new.idordercustomer;
end//  


CREATE TRIGGER OrderAfterUpdate AFTER UPDATE ON ordercustomermerchandise
for each row
begin
declare newsumsale INT default 0;

set newsumsale = (select SUM(countmerch*merchandise.price) from ordercustomermerchandise,merchandise where idordercustomer=new.idordercustomer and ordercustomermerchandise.idmerchandise=merchandise.idmerchandise);
update ordercustomer set sumordercustomer=newsumsale where idordercustomer=new.idordercustomer;
set newsumsale = (select SUM(countmerch*merchandise.price) from ordercustomermerchandise,merchandise where idordercustomer=old.idordercustomer and ordercustomermerchandise.idmerchandise=merchandise.idmerchandise);
update ordercustomer set sumordercustomer=newsumsale where idordercustomer=old.idordercustomer;

end//  


CREATE TRIGGER OrderAfterDelete AFTER DELETE ON ordercustomermerchandise
for each row
begin
declare newsumsale INT default 0;
set newsumsale = (select SUM(countmerch*merchandise.price) from ordercustomermerchandise,merchandise where idordercustomer=old.idordercustomer and ordercustomermerchandise.idmerchandise=merchandise.idmerchandise);
update ordercustomer set sumordercustomer=newsumsale where idordercustomer=old.idordercustomer;
end//  


create view OrdercustomerView as
SELECT dateordercustomer, idordercustomer, customer, phone, address, datedelivery, statusordercustomer, statuspay, (select SUM(countmerch) from ordercustomermerchandise  where idordercustomer=ordercustomer.idordercustomer) as countmerch  FROM ordercustomer, customer WHERE ordercustomer.idcustomer=customer.idcustomer ORDER BY dateordercustomer DESC;





CREATE PROCEDURE OrderCountStreack ( IN dateIN datetime, OUT result int)
BEGIN

    declare current_streak int;
    declare current_status varchar (40);
    declare cur cursor for select statusordercustomer from ordercustomer where dateordercustomer>=dateIN order by dateordercustomer;

    set current_streak=0;

    open cur;


    start_loop: loop
        fetch cur into current_status;
            if current_status <> 'Выполнено' then 
                leave start_loop;
            else
                set current_streak=current_streak+1;
            end if;

    end loop;

    close cur;

    select current_streak into result;

END//









SELECT MaxPriceMerchandise();
SELECT CountOrderClient();

SELECT idmerchandise, price FROM merchandise;
SELECT PriceUp();
SELECT idmerchandise, price FROM merchandise;


SET @p0 = 1;
CALL `CountMerchandise` (@p0, @p1);
SELECT @p1 AS `CountMerchandise` ;

SET @p0 = 1;
CALL `InsertOrder` (@p0);
SELECT idcustomer, statusordercustomer, statuspay, dateordercustomer, sumordercustomer from ordercustomer order by dateordercustomer desc;


select customer from customer;
SET @p0 = 'про';
CALL `FindCustomer` (@p0, @p1);
SELECT @p1 AS `FindCustomer` ;
SET @p0 = 'ро';
CALL `FindCustomer` (@p0, @p1);
SELECT @p1 AS `FindCustomer` ;
SET @p0 = 'мих';
CALL `FindCustomer` (@p0, @p1);
SELECT @p1 AS `FindCustomer` ;






select idordercustomer, sumordercustomer from ordercustomer;
INSERT INTO `ordercustomermerchandise` (`idordercustomer`, `idmerchandise`, `countmerch`) VALUES
(2, 14, 2);
select idordercustomer, sumordercustomer from ordercustomer;




select idordercustomer, sumordercustomer from ordercustomer;
UPDATE `ordercustomermerchandise` SET `idordercustomer` = '3' WHERE `ordercustomermerchandise`.`idordercustomermerchandise` = 8;
select idordercustomer, sumordercustomer from ordercustomer;






select idordercustomer, sumordercustomer from ordercustomer;
delete from `ordercustomermerchandise`  WHERE `ordercustomermerchandise`.`idordercustomermerchandise` = 8;
select idordercustomer, sumordercustomer from ordercustomer;





select * from OrdercustomerView;




SET @p0 = '2024-11-21';
CALL `OrderCountStreack` (@p0, @p1);
SELECT @p1 AS `OrderCountStreack` ;








