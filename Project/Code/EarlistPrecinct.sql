drop procedure if exists EarlistPrecinct;
DELIMITER //
CREATE PROCEDURE EarlistPrecinct(
IN vote_count VARCHAR(255))
BEGIN
select precinct, totalvotes,timestamp from( 
select precinct,totalvotes,timestamp from penna where timestamp in (
select Min(t) from (
SELECT Min(p.timestamp) as t
FROM testdb.penna p
where p.totalvotes>=vote_count) a)
and totalvotes>=vote_count) copy1
where totalvotes in (
select max(totalvotes) from (
select precinct,totalvotes,timestamp from penna where timestamp in (
select Min(t) from (
SELECT Min(p.timestamp) as t
FROM testdb.penna p
where p.totalvotes>=vote_count) a)
and totalvotes>=vote_count) copy2
)
;
END //
DELIMITER ;

call EarlistPrecinct(0)