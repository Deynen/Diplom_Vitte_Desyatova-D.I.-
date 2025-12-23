SELECT * FROM service order by cost



SELECT COUNT(servicing.idservicing) AS COUNTSERVICE, SUM(cost)  AS SUMSERVICE
  FROM servicing
    INNER JOIN service
      ON servicing.idservice = service.idservice
WHERE
dateservice BETWEEN '2021-10-11' AND '2021-11-21'



SELECT COUNT(servicing.idservicing) AS COUNTSERVICE, SUM(cost)  AS SUMSERVICE
  FROM servicing
    INNER JOIN service
      ON servicing.idservice = service.idservice
WHERE
dateservice BETWEEN DATE_ADD(CURDATE(), interval -1 month) AND CURDATE()




SELECT * from client where surname like "ϥ"


SELECT register.datestart, register.dateend, CONCAT(client.surname, ' ', client.name, ' ', client.patr) as client, status.status
FROM register
INNER JOIN client ON client.idclient = register.idclient 
INNER JOIN status ON status.idstatus = register.idstatus  



SELECT register.datestart, register.dateend, CONCAT(client.surname, ' ', client.name, ' ', client.patr) as client, room
FROM register
INNER JOIN client ON client.idclient = register.idclient 
INNER JOIN status ON status.idstatus = register.idstatus  
INNER JOIN room ON room.idroom = register.idroom 
WHERE status like "°﮼"





SELECT register.datestart, register.dateend, CONCAT(client.surname, ' ', client.name, ' ', client.patr) as client, room, category, 
(DATEDIFF(dateend, datestart)) as day, (DATEDIFF(dateend, datestart)*cost) as sum
FROM register
INNER JOIN client ON client.idclient = register.idclient 
INNER JOIN status ON status.idstatus = register.idstatus  
INNER JOIN room ON room.idroom = register.idroom 
INNER JOIN category ON room.idcategory = category.idcategory
WHERE status like "а裡㡭飢



SELECT CONCAT(surname, ' ', name, ' ', patr) as personal, 
(SELECT COUNT(servicing.idservicing) FROM servicing where servicing.idpersonal=personal.idpersonal) as COUNTSERVICE, 
(SELECT SUM(cost) FROM servicing  INNER JOIN service  ON servicing.idservice = service.idservice where servicing.idpersonal=personal.idpersonal) AS SUMSERVICE
FROM personal




SELECT datecomment, CONCAT(surname, ' ', name, ' ', patr) as client, comment, mark
from client, comment
where client.idclient=comment.idclient and client.idclient IN (SELECT idclient FROM servicing)





SELECT room, cost from room, category where room.idcategory=category.idcategory and cost=(select MIN(cost) from category)
















DELIMITER //  
CREATE PROCEDURE InsertPersonal(IN surpersonal varchar(40), IN namepersonal varchar(40), IN patrpersonal varchar(40), IN specpersonal varchar(40) )
BEGIN
insert into personal (surname, name, patr, spec) values (surpersonal, namepersonal, patrpersonal, specpersonal);
END

SET @p1 = "ή㼩";
SET @p2 = "ɢ᫢;
SET @p3 = "ϫ椮㩷";
SET @p4 = "Ю񳽥";
CALL `InsertPersonal` (@p1,@p2,@p3,@p4);
select * from personal;



DELIMITER //  
CREATE PROCEDURE InsertClient(IN surclient varchar(40), IN nameclient varchar(40), IN patrclient varchar(40), IN phoneclient varchar(40), IN pasportclient varchar(40) )
BEGIN
insert into client (surname, name, patr, phone, pasport) values (surclient, nameclient, patrclient, phoneclient, pasportclient);
END

SET @p1 = "ή㼩";
SET @p2 = "ͨ������";
SET @p3 = "Х󱯢鵢;
SET @p4 = "228833";
SET @p5 = "2234 22334";
CALL `InsertClient` (@p1,@p2,@p3,@p4,@p5);
select * from client;


DELIMITER //  
CREATE PROCEDURE UpdateRegister(IN newdate datetime, IN idreg int)
BEGIN
update register set datestart=newdate where idregister=idreg;
END

SET @p1 = '2021-11-01';
SET @p2 = 1;

CALL `UpdateRegister` (@p1,@p2);
select * from register;






DELIMITER //  
CREATE PROCEDURE SumDate ( IN dateroom datetime, OUT sumroom INT)
BEGIN
SET sumroom=(select SUM(cost) from register, room, category where register.idroom=room.idroom and room.idcategory=category.idcategory and datestart<=dateroom and dateend>=dateroom);
END

SET @p0 = '2021-11-19';
CALL `SumDate` (@p0 , @p1);
SELECT @p1 AS `sumroom` ;





DELIMITER //
CREATE PROCEDURE CheckClient ( IN dateroom datetime, IN idcheck int, OUT result varchar(40))
BEGIN
DECLARE COUNTCLIENT int;
SET COUNTCLIENT=(select COUNT(idregister) from register where idclient=idcheck and datestart<=dateroom and dateend>=dateroom);
IF (COUNTCLIENT>0)
THEN
SET result='а裡㡫';
ELSE
SET result='Υ 𐱮穢ᩧ;
END IF;
END;


SET @p0 = '2021-11-19';
SET @p1 = 1;

CALL `CheckClient` (@p0 , @p1, @p2);
SELECT @p2 AS `check` ;






DELIMITER //  
CREATE PROCEDURE UpdateRegisterCheck(IN newdate datetime, IN idreg int)
BEGIN
IF (newdate>CURDATE())
THEN
update register set datestart=newdate where idregister=idreg;
END IF;
END

SET @p1 = '2021-12-25';
SET @p2 = 10;

CALL `UpdateRegisterCheck` (@p1,@p2);
select * from register;









DELIMITER //  
CREATE FUNCTION SumService ()
RETURNS  int
AS
BEGIN
DECLARE sum int;
SET sum=(COUNT(servicing.idservicing) AS COUNTSERVICE, SUM(cost)  AS SUMSERVICE FROM servicing    INNER JOIN service
      ON servicing.idservice = service.idservice
WHERE
dateservice BETWEEN '2021-10-11' AND '2021-11-21');
	RETURN sum;
END;






DELIMITER //  
CREATE FUNCTION SumService ()
RETURNS  int
BEGIN
DECLARE sum int;
SET sum=(SELECT SUM(cost)  AS SUMSERVICE FROM servicing    INNER JOIN service      ON servicing.idservice = service.idservice
WHERE dateservice <= curdate());
	RETURN sum;
END;


SELECT SumService();






DELIMITER //  
CREATE FUNCTION CountReg ()
RETURNS  int
BEGIN
DECLARE count int;
SET count=(SELECT COUNT(idregister) FROM register 
WHERE dateend <= curdate());
	RETURN count;
END;


SELECT CountReg();




DELIMITER //  
CREATE FUNCTION MinService ()
RETURNS  int
BEGIN
DECLARE mincost int;
SET mincost=(SELECT MIN(cost) FROM service);
	RETURN mincost;
END;


SELECT MinService();




DELIMITER //  
CREATE FUNCTION MaxRoom ()
RETURNS  int
BEGIN
DECLARE maxcost int;
SET maxcost=(SELECT MAX(cost) FROM category);
	RETURN maxcost;
END;


SELECT MaxRoom();


DELIMITER //  
CREATE TRIGGER RegisterBeforeInsert BEFORE INSERT ON register
for each row
begin
set new.idstatus=1;
end


DELIMITER //  
CREATE TRIGGER ServiceBeforeInsert BEFORE INSERT ON service
for each row
begin
set new.cost=IFNULL(NULL, 0);
end

