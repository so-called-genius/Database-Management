drop table if exists pennacopy;
create table pennacopy as(select * from penna);

drop table if exists `InsertedTuples`;
CREATE TABLE `testDB`.`InsertedTuples` ( 
  `ID` INT NULL,
  `Timestamp` DATETIME NULL, 
  `state` VARCHAR(45) NULL, 
  `locality` VARCHAR(45) NULL, 
  `precinct` VARCHAR(45) NULL, 
  `geo` VARCHAR(45) NULL, 
  `totalvotes` INT NULL, 
  `Biden` INT NULL, 
  `Trump` INT NULL
  );

use testdb;
Drop Trigger if exists Insertdata;
DELIMITER $$
CREATE TRIGGER Insertdata
	AFTER insert On pennacopy
	FOR EACH ROW
BEGIN
INSERT INTO `InsertedTuples`(ID,Timestamp,state,locality,precinct,geo,totalvotes,Biden,Trump) 
VALUES(new.ID,new.Timestamp,new.state,new.locality,new.precinct,new.geo,new.totalvotes,new.Biden,new.Trump);
END$$
DELIMITER ;
insert into pennacopy(ID) values(222)