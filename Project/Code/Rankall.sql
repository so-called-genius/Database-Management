drop procedure if exists Rankall;
DELIMITER //
CREATE PROCEDURE Rankall(
IN precinct VARCHAR(255))
BEGIN
select ranking from (
SELECT p.precinct, rank() 
OVER ( order by p.totalvotes desc ) 
AS 'ranking' 
FROM testdb.penna p where  timestamp in (select max(timestamp) from Penna)
) a where a.precinct=precinct;
END //
DELIMITER ;

call Rankall('033 W BRADFORD 5')