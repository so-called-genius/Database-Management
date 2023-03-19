drop procedure if exists RankTimestamp;
DELIMITER //
CREATE PROCEDURE RankTimestamp()
BEGIN
drop table if exists Times;
create table Times as (select distinct Timestamp, sum(totalvotes) as totalv from Penna group by Timestamp );

select tt.timestamp, TimestampDiff(Second,t.timestamp,tt.timestamp) as Delta,tt.totalv-t.totalv as Gain,
(tt.totalv-t.totalv)/(TimestampDiff(Second,t.timestamp,tt.timestamp)) as ratio
 from Times t join Times tt where
t.Timestamp in (select max(timestamp) from Times where timestamp<tt.timestamp)
order by ratio desc
;
END //
DELIMITER ;

call RankTimestamp()