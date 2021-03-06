--mysql -D diploid -u mgr -p 


DROP TABLE IF EXISTS affyprobeset;

CREATE TABLE affyprobeset (
 	probesetID   VARCHAR(20) NOT NULL PRIMARY KEY ,
	alleleA     CHAR(1),
	alleleB     CHAR(1)
);

DROP TABLE IF EXISTS map_probesetID_rsid;

CREATE TABLE map_probesetID_rsid  (
	probesetID   VARCHAR(20) NOT NULL PRIMARY KEY,
 	rsid        VARCHAR(20) NOT NULL 
);


DROP TABLE IF EXISTS birdseedcall;

CREATE TABLE birdseedcall (
 	caseID          CHAR(36) NOT NULL,
	probesetID      VARCHAR(20) NOT NULL,
	intCall         TINYINT,
	confidencescore FLOAT(5,4),
	PRIMARY KEY (caseid, probesetID)
);


DROP TABLE IF EXISTS hg19snp147;

CREATE TABLE `hg19snp147` (
  `bin` smallint(5) unsigned NOT NULL,
  `chrom` varchar(31) NOT NULL,
  `chromStart` int(10) unsigned NOT NULL,
  `chromEnd` int(10) unsigned NOT NULL,
  `name` varchar(15) NOT NULL,
  `score` smallint(5) unsigned NOT NULL,
  `strand` enum('+','-') NOT NULL,
  `refNCBI` blob NOT NULL,
  `refUCSC` blob NOT NULL,
  `observed` varchar(255) NOT NULL,
  `molType` enum('unknown','genomic','cDNA') NOT NULL,
  `class` enum('single','in-del','microsatellite','named','mnp','insertion','deletion') NOT NULL,
  `valid` set('unknown','by-cluster','by-frequency','by-submitter','by-2hit-2allele','by-hapmap','by-1000genomes') NOT NULL,
  `avHet` float NOT NULL,
  `avHetSE` float NOT NULL,
  `func` set('unknown','coding-synon','intron','near-gene-3','near-gene-5','ncRNA','nonsense','missense','stop-loss','frameshift','cds-indel','untranslated-3','untranslated-5','splice-3','splice-5') NOT NULL,
  `locType` enum('range','exact','between','rangeInsertion','rangeSubstitution','rangeDeletion','fuzzy') NOT NULL,
  `weight` int(10) unsigned NOT NULL,
  `exceptions` set('RefAlleleMismatch','RefAlleleRevComp','DuplicateObserved','MixedObserved','FlankMismatchGenomeLonger','FlankMismatchGenomeEqual','FlankMismatchGenomeShorter','SingleClassLongerSpan','SingleClassZeroSpan','SingleClassTriAllelic','SingleClassQuadAllelic','ObservedWrongFormat','ObservedTooLong','ObservedContainsIupac','ObservedMismatch','MultipleAlignments','NonIntegerChromCount','AlleleFreqSumNot1','SingleAlleleFreq','InconsistentAlleles') NOT NULL,
  `submitterCount` smallint(5) unsigned NOT NULL,
  `submitters` longblob NOT NULL,
  `alleleFreqCount` smallint(5) unsigned NOT NULL,
  `alleles` longblob NOT NULL,
  `alleleNs` longblob NOT NULL,
  `alleleFreqs` longblob NOT NULL,
  `bitfields` set('clinically-assoc','maf-5-some-pop','maf-5-all-pops','has-omim-omia','microattr-tpa','submitted-by-lsdb','genotype-conflict','rs-cluster-nonoverlapping-alleles','observed-mismatch') NOT NULL,
  KEY `name` (`name`),
  KEY `chrom` (`chrom`,`bin`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;



DROP TABLE IF EXISTS decodeintegercall;

CREATE TABLE decodeintegercall (
  probesetID      VARCHAR(20) NOT NULL,
  intCall         TINYINT,
  acgtCall        CHAR(2),
  PRIMARY KEY (probesetID, intCall)
);


DROP TABLE IF EXISTS hg19IGSR;

CREATE TABLE hg19IGSR (
  chrom    VARCHAR(2) NOT NULL,
  position int(10) unsigned NOT NULL,
  rsid     VARCHAR(20) NOT NULL PRIMARY KEY, 
  A1       VARCHAR(20) NOT NULL,
  A2       VARCHAR(20) NOT NULL,
  AFR      FLOAT(5,4),
  AMR      FLOAT(5,4),
  EAS      FLOAT(5,4),
  EUR      FLOAT(5,4),
  SAS      FLOAT(5,4)
);


CREATE TABLE test (
  chrom    VARCHAR(2) NOT NULL,
  position int(10) unsigned NOT NULL,
  rsid     VARCHAR(20) NOT NULL PRIMARY KEY,
  A1       VARCHAR(20),
  A2       VARCHAR(20),
  AFR      FLOAT(5,4),
  AMR      FLOAT(5,4),
  EAS      FLOAT(5,4),
  EUR      FLOAT(5,4),
  SAS      FLOAT(5,4)
);





