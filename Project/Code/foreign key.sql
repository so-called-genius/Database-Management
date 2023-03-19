ALTER TABLE penna1copy
ADD PRIMARY KEY (precinct);
ALTER TABLE penna2copy
ADD FOREIGN KEY (precinct) REFERENCES penna1copy (precinct);

INSERT INTO penna2copy(Biden) 
VALUES(33);