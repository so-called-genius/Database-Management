use testdb;
Drop table if exists Penna2;
Drop table if exists Penna2copy;
Drop table if exists Penna1;
Drop table if exists Penna1copy;

CREATE TABLE Penna1 AS (SELECT distinct t.precinct,t.geo,t.locality,t.state FROM testdb.penna t);
CREATE TABLE Penna1copy AS (SELECT distinct t.precinct,t.geo,t.locality,t.state FROM testdb.penna t);
CREATE TABLE Penna2 AS (SELECT distinct t.Timestamp,t.precinct, t.totalvotes, t.Biden,t.Trump FROM testdb.penna t);
CREATE TABLE Penna2copy AS (SELECT distinct t.Timestamp,t.precinct, t.totalvotes, t.Biden,t.Trump FROM testdb.penna t);

#CREATE TABLE Penna AS (SELECT distinct t.timestamp,t.precinct,t.geo,t.locality,t.state FROM testdb.penna2 t,testdb.penna1 tt where t.precinct=tt.precinct);