drop procedure if exists PrecinctsWonCount;
DELIMITER //
CREATE PROCEDURE PrecinctsWonCount(
IN candidate VARCHAR(255))
BEGIN
select count(precinct) from(
select precinct, totalvotes,timestamp,
CASE
    WHEN candidate="Trump" THEN Trump-Biden
    WHEN candidate="Biden" THEN Biden-Trump
    ELSE 0
END as 'diff'
from Penna) a
where diff>0 and timestamp in (select max(timestamp) from Penna)
;
END //
DELIMITER ;

call PrecinctsWonCount("Biden")