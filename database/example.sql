
# rs6906846
# hg19: chr6:31245736     6_

SELECT M.rsid, D.*, P.alleleA, P.alleleB, 
       H.chrom, H.chromEnd, H.strand, H.refNCBI, H.observed
  FROM decodeintegercall AS D
     INNER JOIN map_probsetID_rsid  AS M ON D.probesetID = M.probesetID
     INNER JOIN affyprobeset        AS P ON D.probesetID = P.probesetID
     INNER JOIN hg19snp147          AS H ON H.name = M.rsid
  WHERE  M.rsid='rs6906846'



SELECT M.rsid, D.*, P.alleleA, P.alleleB, 
       H.chrom, H.chromEnd, H.strand, H.refNCBI, H.observed
  FROM decodeintegercall AS D
     INNER JOIN map_probsetID_rsid  AS M ON D.probesetID = M.probesetID
     INNER JOIN affyprobeset        AS P ON D.probesetID = P.probesetID
     INNER JOIN hg19snp147          AS H ON H.name = M.rsid
  WHERE  M.rsid='rs12984174'