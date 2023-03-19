drop procedure if exists PrecinctsFullLead;
DELIMITER //
CREATE PROCEDURE PrecinctsFullLead(
IN candidate VARCHAR(255))
BEGIN
select distinct precinct from Penna p
where not exists(
select * from(
select precinct, totalvotes,Trump,Biden,
CASE
    WHEN candidate="Trump" THEN Trump-Biden
    WHEN candidate="Biden" THEN Biden-Trump
    ELSE 0
END as 'diff'
from Penna) a 
where (a.diff <=0 and not (a.Biden=0 and a.Trump=0))and p.precinct=a.precinct)
;
END //
DELIMITER ;

call PrecinctsFullLead("Biden")