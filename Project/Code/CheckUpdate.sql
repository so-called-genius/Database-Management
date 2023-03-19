drop procedure if exists CheckUpdate;
DELIMITER //
CREATE PROCEDURE CheckUpdate(
IN 
ttimestamp DATETIME , 
  sstate VARCHAR(45) ,
  llocality VARCHAR(45) , 
  pprecinct VARCHAR(45) , 
  ggeo VARCHAR(45) , 
  ttotalvotes INT , 
  BBiden INT , 
  TTrump INT,
  tttimestamp DATETIME , 
  ssstate VARCHAR(45) ,
  lllocality VARCHAR(45) , 
  ppprecinct VARCHAR(45) , 
  gggeo VARCHAR(45) , 
  tttotalvotes INT , 
  BBBiden INT , 
  TTTrump INT,
  ttable varchar(45))
sp:BEGIN
if ttable="penna1" then
if exists(select * from penna1 where precinct=ppprecinct and pprecinct!=ppprecinct and (locality!=lllocality or geo!=gggeo or state!=ssstate)) then
 select "Update rejected due to constraint violation for primary key";
leave sp;
end if;
if exists(select * from penna2 where precinct=pprecinct) and pprecinct!=ppprecinct then
 select "Update rejected due to constraint violation for foreign key in penna2";
 leave sp;
end if;
select "Update accepted";
Update `penna1`
set state=ssstate,locality=lllocality,precinct=ppprecinct,geo=gggeo
where state=sstate and locality=llocality and precinct=pprecinct and geo=ggeo;
leave sp;
end if;

if ttable="penna2" then
if exists(select * from penna2 where precinct=ppprecinct and timestamp=tttimestamp and 
(totalvotes!=tttotalvotes or Biden!=BBBiden or TTTrump!=Trump)) and (pprecinct!=ppprecinct or ttimestamp!=tttimestamp) then
 select "Update rejected due to constraint violation for primary key";
leave sp;
 end if;
 if ppprecinct not in (select precinct from penna1) then
 select "Update rejected due to constraint violation for foreign key";
 leave sp;
 end if;
 if TTTrump+BBBiden>tttotalvotes then
 select "Update rejected due to constraint violation for Part3 a";
 leave sp;
 end if;
 if tttimestamp>="2020-11-12 00:00:00" or tttimestamp<"2020-11-03 00:00:00" then 
 select "insertion rejected due to constraint violation for Part3 b";
 leave sp;
 end if;
 
 if tttimestamp>"2020-11-05 00:00:00" then
 if exists(select * from penna2 p where p.timestamp <"2020-11-05 00:00:00" and p.precinct=ppprecinct and (p.biden>BBBiden or p.trump>TTTrump or p.totalvotes>tttotalvotes))  then
 select "Update rejected due to constraint violation for Part3 c";
 leave sp;
 end if;
end if;

 if tttimestamp<"2020-11-05 00:00:00" then
 if exists(select * from penna2 p where p.timestamp>"2020-11-05 00:00:00" and p.precinct=ppprecinct and (p.biden<BBBiden or p.trump<TTTrump or p.totalvotes<tttotalvotes))  then
 select "Update rejected due to constraint violation for Part3 c";
 leave sp;
 end if;
 end if;
 
 select "Update accepted";
Update `penna2`
set timestamp=tttimestamp,precinct=ppprecinct,totalvotes=tttotalvotes,Biden=BBBiden,Trump=TTTrump
where timestamp=ttimestamp and precinct=pprecinct and totalvotes=ttotalvotes and Biden=BBiden and Trump=TTrump;
leave sp;
end if;
select "unknown table";
END //
DELIMITER ;

Call CheckUpdate("2020-11-04 03:58:36","PA",'Cambria','Adams Township - Dunlo Voting Precinct','42021-ADAMS TWP DUNLO',0,0,0,
"2020-11-04 03:58:36","PA",'Cambriaa','Adams Township - Elton Voting Precinct','42021-ADAMS TWP DUNLO',0,0,0,"Penna1");

Call CheckUpdate("2020-11-04 03:58:36","PA",'Cambria','Adams Township - Dunlo Voting Precinct','42021-ADAMS TWP DUNLO',0,0,0,
"2020-11-04 03:58:36","PA",'Cambria','testcase','42021-ADAMS TWP DUNLO',0,0,0,"Penna1");

Call CheckUpdate("2020-11-04 03:58:36","PA",'Cambria','Adams Township - Dunlo Voting Precinct','42021-ADAMS TWP DUNLO',0,0,0,
"2020-11-04 03:58:36","PA",'Cambriaa','Adams Township - Dunlo Voting Precinct','42021-ADAMS TWP DUNLO',0,0,0,"Penna1");

Call CheckUpdate('2020-11-04 03:58:36',"","",'Adams Township - St. Michael Voting Precinct',"",490,113,372,
'2020-11-04 03:58:36',"","",'Adams Township - Dunlo Voting Precinct',"",20,10,10,"Penna2");

Call CheckUpdate('2020-11-04 03:58:36',"","",'Adams Township - St. Michael Voting Precinct',"",490,113,372,
'2020-11-04 03:58:36',"","",'testcase',"",20,10,10,"Penna2");

Call CheckUpdate('2020-11-04 03:58:36',"","",'Adams Township - St. Michael Voting Precinct',"",490,113,372,
'2020-11-04 03:58:36',"","",'Adams Township - St. Michael Voting Precinct',"",20,20,10,"Penna2");

Call CheckUpdate('2020-11-04 03:58:36',"","",'Adams Township - St. Michael Voting Precinct',"",490,113,372,
'2020-11-20 03:58:36',"","",'Adams Township - St. Michael Voting Precinct',"",490,113,372,"Penna2");

Call CheckUpdate('2020-11-04 03:58:36',"","",'Adams Township - St. Michael Voting Precinct',"",490,113,372,
'2020-11-04 03:58:36',"","",'Adams Township - St. Michael Voting Precinct',"",100000,0,0,"Penna2");

Call CheckUpdate('2020-11-04 03:58:36',"","",'Adams Township - St. Michael Voting Precinct',"",490,113,372,
'2020-11-04 03:58:36',"","",'Adams Township - St. Michael Voting Precinct',"",491,113,372,"Penna2");