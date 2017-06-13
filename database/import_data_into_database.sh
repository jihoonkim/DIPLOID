
mysqlimport diploid -u mgr -pmgrpasswd /scratch/DATABASE/affyprobeset.txt \
 --ignore-lines=1 --lines-terminated-by='\n'


mysqlimport diploid -u mgr -pmgrpasswd /scratch/DATABASE/map_probesetID_rsid.txt \
 --ignore-lines=1 --lines-terminated-by='\n'


mysqlimport diploid -u mgr -pmgrpasswd /scratch/DATABASE/birdseedcall.txt \
 --ignore-lines=1 --lines-terminated-by='\n' 


mysqlimport diploid -u mgr -pmgrpasswd /scratch/DATABASE/hg19snp147.txt \
--lines-terminated-by='\n' 


mysqlimport diploid -u mgr -pmgrpasswd /scratch/DATABASE/decodeintegercall.txt \
  --ignore-lines=1  --lines-terminated-by='\n' 

