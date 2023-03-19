Drop table if exists PennaS;
Drop table if exists PennaT;
create table PennaS as (select precinct, Timestamp, totalvotes,biden,trump from Penna where timestamp<"2020-11-05 00:00:00");
create table PennaT as (select precinct, Timestamp, totalvotes,biden,trump from Penna where timestamp>"2020-11-05 00:00:00");
create index indprec on PennaS(precinct);
create index indprecc on PennaT(precinct);
create index indtim on PennaS(Timestamp);
create index indtimm on PennaT(Timestamp);
select if (not exists(select * from PennaS s, PennaT t where  s.precinct =t.precinct
 and (s.totalvotes > t.totalvotes or s.Biden>t.Biden or s.Trump>t.trump)) ,"True","False")
