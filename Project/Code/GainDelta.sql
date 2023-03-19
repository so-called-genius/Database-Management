
drop procedure if exists GainDelta;
DELIMITER //
CREATE PROCEDURE GainDelta(
IN ti VARCHAR(255))
BEGIN

drop table if exists Times;
create table Times as (select distinct Timestamp, sum(totalvotes) as totalv from Penna group by Timestamp );

select TimestampDiff(Second,t.timestamp,ti) as Delta,tt.totalv-t.totalv as Gain,
(tt.totalv-t.totalv)/(TimestampDiff(Second,t.timestamp,ti)) as ratio
 from Times t join Times tt where
t.Timestamp in (select max(timestamp) from Penna where timestamp<ti) and tt.timestamp=ti
;
END //
DELIMITER ;

call GainDelta('2020-11-04 03:58:36')