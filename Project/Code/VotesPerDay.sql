drop procedure if exists VotesPerDay;
DELIMITER //
CREATE PROCEDURE VotesPerDay(in d varchar(255))
BEGIN
select d as Day, timestamp,precinct,Biden,Trump,totalvotes from Penna where Day(Timestamp)=d
;
END //
DELIMITER ;

call VotesPerDay("09")