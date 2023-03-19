drop procedure if exists PrecinctsWon;
DELIMITER //
CREATE PROCEDURE PrecinctsWon(
IN candidate VARCHAR(255))
BEGIN
select precinct,totalvotes,diff from(
select precinct, totalvotes,timestamp,
CASE
    WHEN candidate="Trump" THEN Trump-Biden
    WHEN candidate="Biden" THEN Biden-Trump
    ELSE 0
END as 'diff'
from Penna) a
where diff>0 and timestamp in (select max(timestamp) from Penna)
order by diff
;
END //
DELIMITER ;

call PrecinctsWon("Trump")