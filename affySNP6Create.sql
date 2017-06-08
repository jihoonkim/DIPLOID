--Create the affySNP6 database for birdseed to ped file conversion--
CREATE DATABASE IF NOT EXISTS affySNP6;
SHOW DATABASES;
USE affySNP6;

CREATE TABLE IF NOT EXISTS affyProbe(
probeID varchar(45) NOT NULL,
alleleA char(1) null default null,
alleleB char(1) null default null,
PRIMARY KEY(probeID)
);

CREATE TABLE IF NOT EXISTS rsidProbeMap(
rsid varchar(45) NOT NULL,
probeID varchar(45) NOT NULL,
PRIMARY KEY(probeID)
);

--DROP TABLE if exists hg18MAP;
CREATE TABLE IF NOT EXISTS hg18Map(
chrNumber char(2) not null,
rsid varchar(45) NOT NULL,
geneticDist float not null,
location int not null,
PRIMARY KEY(rsid)
);

CREATE TABLE IF NOT EXISTS metaInfo(
race varchar(45) NOT NULL,
ethinicity varchar(45) NOT NULL,
caseID varchar(45) not null,
primarySite varchar(45) not null,
sampleType varchar(45) not null,
gender varchar(45) not null, 
fileID varchar(45) not null,
PRIMARY KEY(fileID)
);

CREATE TABLE IF NOT EXISTS birdSeed(
caseID varchar(45) NOT NULL,
probeID varchar(45) NOT NULL,
calling int NOT NULL,
confidence float not NULL,
PRIMARY KEY(caseID, probeID)
);
