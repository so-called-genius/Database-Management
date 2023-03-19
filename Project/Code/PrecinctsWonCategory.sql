drop procedure if exists PrecinctsWonCategory;
DELIMITER //
CREATE PROCEDURE PrecinctsWonCategory()
BEGIN
call PrecinctsWonTownships();
END //
DELIMITER ;

drop procedure if exists PrecinctsWonTownships;
DELIMITER //
CREATE PROCEDURE PrecinctsWonTownships()
BEGIN
select sum(Trump),sum(Biden),abs(sum(Trump)-sum(Biden)) as "diff",
CASE
    WHEN sum(Trump)-sum(Biden)>0 THEN "Trump"
    WHEN sum(Trump)-sum(Biden)<0 THEN "Biden"
    ELSE "Draw"
END as 'Winner'
from Penna where 
precinct in (SELECT precinct from Penna where precinct like '%Township%') and timestamp in (select Max(timestamp) from Penna);
END //
DELIMITER ;

call PrecinctsWonCategory()