

drop procedure if exists MoveVotes;
DELIMITER //
CREATE PROCEDURE MoveVotes(
IN Precinct VARCHAR(255),
  Timest DATETIME, 
  CoreCandidate VARCHAR(45), 
  Number_of_Moved_Votes int)
sp:BEGIN
if not exists(select * from pennacopy p where p.precinct=Precinct and p.timestamp=Timest) 
	then select "unknow timestamp";
    leave sp;
    end if;

if CoreCandidate="Trump" then
 if not exists(select * from pennacopy p where p.precinct=Precinct and p.timestamp=Timest and p.trump>Number_of_Moved_Votes) then
 select "not enough votes";
 leave sp;
end if;
UPDATE pennacopy
SET Trump=trump-Number_of_Moved_Votes, Biden=Biden+Number_of_Moved_Votes
WHERE timestamp<=Timest;
end if;

if CoreCandidate="Biden" then
 if not exists(select * from pennacopy p where p.precinct=Precinct and p.timestamp=Timest and p.biden>Number_of_Moved_Votes) then
 select "not enough votes";
 leave sp;
end if;
UPDATE pennacopy
SET Trump=trump+Number_of_Moved_Votes, Biden=Biden-Number_of_Moved_Votes
WHERE timestamp<=Timest;
end if;
if CoreCandidate!="Trump" and CoreCandidate!="Biden" then select "Wrong candidate"; leave sp; end if;

END //
DELIMITER ;

call MoveVotes('Adams Township - Dunlo Voting Precinct','2020-11-04 03:58:36','Trump',100)