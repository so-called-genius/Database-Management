

drop procedure if exists CheckDeletion;
DELIMITER //
CREATE PROCEDURE CheckDeletion(
IN 
ttimestamp DATETIME , 
  sstate VARCHAR(45) , 
  llocality VARCHAR(45) , 
  pprecinct VARCHAR(45) , 
  ggeo VARCHAR(45) , 
  ttotalvotes INT , 
  BBiden INT , 
  TTrump INT,
  ttable varchar(45))
sp:BEGIN
if ttable="penna1" then

if exists(select * from penna2 where precinct=pprecinct) then
 select "Deletion rejected due to constraint violation for foreign key in penna2";
leave sp;
end if;
select "Deletion accepted";
Delete from `penna1` where state=sstate and locality=llocality and precinct=pprecinct and geo=ggeo;
leave sp;
end if;

if ttable="penna2" then
select "Deletion accepted";
Delete from `penna2` where timestamp=ttimestamp and precinct=pprecinct and totalvotes=ttotalvotes and Biden=BBiden and Trump=TTrump;
leave sp;
end if;

select "unknown table";
END //
DELIMITER ;
Call CheckDeletion("2020-11-04 03:58:36","PA",'Cambria','Adams Township No. 1 Voting Precinct','42021-ADAMS TWP 1',0,0,0,"Penna1");

Call CheckDeletion('2020-11-04 03:58:36',"","",'Adams Township - St. Michael Voting Precinct',"",490,113,372,"Penna2");