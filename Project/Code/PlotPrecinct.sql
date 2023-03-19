drop procedure if exists PlotPrecinct;
DELIMITER //
CREATE PROCEDURE PlotPrecinct(
IN Pre VARCHAR(255))
Begin
select timestamp, Trump from penna where precinct=Pre order by timestamp;
select timestamp, Biden from penna where precinct=Pre order by timestamp;
select timestamp, totalvotes from penna where precinct=Pre order by timestamp;
End //
DELIMITER ;
call PlotPrecinct('Adams Township - Dunlo Voting Precinct')