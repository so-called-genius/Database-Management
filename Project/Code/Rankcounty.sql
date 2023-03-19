drop procedure if exists Rankcounty;
DELIMITER //
CREATE PROCEDURE Rankcounty(
IN precinct VARCHAR(255))
BEGIN
select ranking from(
SELECT p.locality, p.precinct, p.totalvotes,rank() 
OVER (partition by p.locality order by p.totalvotes desc ) 
AS 'ranking' 
FROM testdb.penna p where  timestamp in (select max(timestamp) from Penna)) a
where
a.precinct=precinct;
END //
DELIMITER ;

call Rankcounty('033 W BRADFORD 5')