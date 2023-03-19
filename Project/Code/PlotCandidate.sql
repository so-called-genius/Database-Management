drop procedure if exists PlotCandidate;
DELIMITER //
CREATE PROCEDURE PlotCandidate(
IN Can VARCHAR(255))
Begin
Case when Can="Biden" then select timestamp, sum(Biden) from penna group by timestamp order by timestamp;
     when Can="Trump" then select timestamp, sum(Trump) from penna group by timestamp order by timestamp;
end case;
End //
DELIMITER ;
call PlotCandidate('Trump');
call PlotCandidate('Biden');