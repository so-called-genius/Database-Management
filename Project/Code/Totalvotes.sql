drop procedure if exists TotalVotes;
DELIMITER //
CREATE PROCEDURE TotalVotes(
IN ti VARCHAR(255), category varchar(255) )
BEGIN
select precinct,
case
     When category="ALL" Then totalvotes
     WHen category="Trump" Then trump
     When category="Biden" then Biden
     else Biden
End as count
from penna where timestamp=ti 
order by 
case
     When category="ALL" Then totalvotes
     WHen category="Trump" Then trump
     When category="Biden" then Biden
     else Biden
ENd;
END //
DELIMITER ;

call TotalVotes('2020-11-04 03:58:36',"Biden")