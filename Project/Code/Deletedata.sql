drop table if exists pennacopy;
create table pennacopy as(select * from penna);
drop table if exists DeletedTuples;
CREATE TABLE `testDB`.`DeletedTuples` ( 
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
Drop Trigger if exists Deletedata;
DELIMITER $$
CREATE TRIGGER Deletedata
	AFTER delete On pennacopy
	FOR EACH ROW
BEGIN
INSERT INTO DeletedTuples(ID,Timestamp,state,locality,precinct,geo,totalvotes,Biden,Trump) 
VALUES(old.ID,old.Timestamp,old.state,old.locality,old.precinct,old.geo,old.totalvotes,old.Biden,old.Trump);
END$$
DELIMITER ;



DELETE FROM pennacopy WHERE precinct='Adams Township - Elton Voting Precinct';