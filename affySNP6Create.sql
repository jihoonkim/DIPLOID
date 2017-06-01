--Create the affySNP6 database for birdseed to ped file conversion--
--


CREATE TABLE affyProbe(
probeID varchar(45) NOT NULL,
alleleA char(1) null default null,
alleleB char(1) null default null,
PRIMARY KEY(probeID)
);

CREATE TABLE rsidProbeMap(
rsid varchar(45) NOT NULL,
probeID varchar(45) NOT NULL,
PRIMARY KEY(probeID)
);

CREATE TABLE hg18Map(
rsid varchar(45) NOT NULL,
chrNumber char(2) not null,
geneticDist float not null,
PRIMARY KEY(rsid)
);

CREATE TABLE metaInfo(
race varchar(45) NOT NULL,
ethinicity varchar(45) NOT NULL,
caseID varchar(45) not null,
primarySite varchar(45) not null,
sampleType varchar(45) not null,
gender varchar(45) not null, 
fileID varchar(45) not null,
PRIMARY KEY(fileID)
);

CREATE TABLE birdSeed(
caseID varchar(45) NOT NULL,
probeID varchar(45) NOT NULL,
calling int NOT NULL,
confidence float not NULL,
PRIMARY KEY(caseID, probeID)
);