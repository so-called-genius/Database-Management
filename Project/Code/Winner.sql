drop procedure if exists Winner;
DELIMITER //
CREATE PROCEDURE Winner(
IN precinct VARCHAR(255))
BEGIN
select 
CASE
    WHEN Trump>Biden THEN "Trump"
    WHEN Trump<Biden THEN "Biden"
    ELSE "Draw"
END AS Winner,
CASE
    WHEN Trump>Biden THEN Trump/totalvotes*100
    WHEN Trump<Biden THEN Biden/totalvotes*100
    ELSE "Draw"
END AS 'Percentage(%)',
totalvotes
FROM testdb.penna p where p.precinct=precinct and timestamp in (select max(timestamp) from Penna);

END //
DELIMITER ;

call Winner('520 E PIKELAND 2')