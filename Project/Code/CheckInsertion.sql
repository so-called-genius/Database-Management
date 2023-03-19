drop procedure if exists CheckInsert;
DELIMITER //
CREATE PROCEDURE CheckInsert(
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
if exists(select * from penna1 where precinct=pprecinct and (locality!=llocality or geo!=ggeo or state!=sstate)) then
 select "insertion rejected due to constraint violation for primary key";
leave sp;
end if;
select "Insertion accepted";
INSERT INTO `penna1`(state,locality,precinct,geo) 
VALUES(sstate,llocality,pprecinct,ggeo);
leave sp;
end if;

if ttable="penna2" then
if exists(select * from penna2 where precinct=pprecinct and timestamp=ttimestamp and 
(totalvotes!=ttotalvotes or Biden!=BBiden or TTrump!=Trump)) then
 select "insertion rejected due to constraint violation for primary key";
leave sp;
 end if;
 if pprecinct not in (select precinct from penna1) then
 select "insertion rejected due to constraint violation for foreign key";
 leave sp;
 end if;
 if TTrump+BBiden>ttotalvotes then
 select "insertion rejected due to constraint violation for Part3 a";
 leave sp;
 end if;
 if ttimestamp>="2020-11-12 00:00:00" or ttimestamp<"2020-11-03 00:00:00" then 
 select "insertion rejected due to constraint violation for Part3 b";
 leave sp;
 end if;
 if ttimestamp>"2020-11-05 00:00:00" then
 if exists(select * from penna2 where timestamp<"2020-11-05 00:00:00" and precinct=pprecinct and (biden>BBiden or trump>TTrump or totalvotes>ttotalvotes)) then
 select "insertion rejected due to constraint violation for Part3 c";
 leave sp;
 end if;
end if;

 if ttimestamp<"2020-11-05 00:00:00" then
 if exists(select * from penna2 where timestamp>"2020-11-05 00:00:00" and precinct=pprecinct and (biden<BBiden or trump<TTrump or totalvotes<ttotalvotes)) then
 select "insertion rejected due to constraint violation for Part3 c";
 leave sp;
 end if;
 
 select "insertion accepted";
 INSERT INTO `penna2`(Timestamp,precinct,totalvotes,Biden,Trump) 
VALUES(ttimestamp,pprecinct,ttotalvotes,BBiden,TTrump);
leave sp;
end if;
end if;
select "unknown table";
END //
DELIMITER ;

Call CheckInsert("2020-11-04 03:58:36","P",'Cambria','Adams Township - Dunlo Voting Precinct','42021-ADAMS TWP DUNLO',0,0,0,"Penna1");
Call CheckInsert("2020-11-04 03:58:36","PA",'Cambria','Adams Township - Dunlo Voting Precinct','42021-ADAMS TWP DUNLO',0,0,0,"Penna1");

Call CheckInsert('2020-11-04 03:58:36',"","",'Adams Township - Dunlo Voting Precinct',"",20,10,10,"Penna2");
Call CheckInsert('2020-11-04 03:58:37',"","",'AAAAAdams Township - Dunlo Voting Precinct',"",20,10,10,"Penna2");
Call CheckInsert('2020-11-04 03:58:37',"","",'Adams Township - Dunlo Voting Precinct',"",10,10,10,"Penna2");
Call CheckInsert('2020-11-02 03:58:37',"","",'Adams Township - Dunlo Voting Precinct',"",20,10,10,"Penna2");
Call CheckInsert('2020-11-04 03:58:37',"","",'Adams Township - Dunlo Voting Precinct',"",20000,10000,10000,"Penna2");
Call CheckInsert('2020-11-04 03:58:37',"","",'Adams Township - Dunlo Voting Precinct',"",20,10,10,"Penna2");