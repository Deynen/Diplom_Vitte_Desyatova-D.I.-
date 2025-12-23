DELIMITER //  
CREATE PROCEDURE SaleMerch ( IN idsaleval int, OUT countsale INT)
BEGIN
SET countsale=(SELECT SUM(countmerch) from detail, sale  WHERE sale.idsale=detail.idsale and sale.idsale=idsaleval);
END

SET @p0 = 2;
CALL `SaleMerch` (@p0 , @p1);
SELECT @p1 AS `countsale` ;



DELIMITER //  
CREATE PROCEDURE InsertSale(IN iduserval int)
BEGIN
insert into sale (iduser, kind, datesale, sumsale) values (iduserval, 'Заказ', Now(), 0);
END

SET @p0 = 1;
CALL `InsertSale` (@p0);
select * from sale;



DELIMITER //  
CREATE TRIGGER DetailAfterInsert AFTER INSERT ON detail
for each row
begin
declare newsumsale INT default 0;
set newsumsale = (select SUM(countmerch*merch.price) from detail,merch where idsale=new.idsale and detail.idmerch=merch.idmerch);
update sale set sumsale=newsumsale where idsale=new.idsale;
end

DELIMITER //  
CREATE TRIGGER DetailAfterUpdate AFTER UPDATE ON detail
for each row
begin
declare newsumsale INT default 0;
set newsumsale = (select SUM(countmerch*merch.price) from detail,merch where idsale=new.idsale and detail.idmerch=merch.idmerch);
update sale set sumsale=newsumsale where idsale=new.idsale;
set newsumsale = (select SUM(countmerch*merch.price) from detail,merch where idsale=old.idsale and detail.idmerch=merch.idmerch);
update sale set sumsale=newsumsale where idsale=old.idsale;
end

DELIMITER //  
CREATE TRIGGER DetailAfterDelete AFTER DELETE ON detail
for each row
begin
declare newsumsale INT default 0;
set newsumsale = (select SUM(countmerch*merch.price) from detail,merch where idsale=old.idsale and detail.idmerch=merch.idmerch);
update sale set sumsale=newsumsale where idsale=old.idsale;
end




create view UserSale as
select fio, phone, mail, kind, datesale, sumsale 
from user, sale where sale.iduser=user.iduser;
select * from UserSale;