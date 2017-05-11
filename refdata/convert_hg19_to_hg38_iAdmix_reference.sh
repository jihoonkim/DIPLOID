#-----------------------------------------------------------------------------------
# Filename: convert_hg19_to_hg38_iAdmix_reference.sh
# Author: Jihoon Kim
# Email:  j5kim@ucsd.edu
# Description: Convert iAdmix reference data cooordinates from hg19 to hg38.
#              For example,
#              rs6906846      hg19 6:31245736  --->  hg38 6:31277959
# Input: A whitespace-delimited .txt file with ten columns as below.
#         #chrom position rsid A1 A2 AMR AFR EUR SAS EAS
#         6 31245736 rs6906846 A G 0.7411 0.6787 0.6256 0.6899 0.6748
#        http://www.ensembl.org/Homo_sapiens/Variation/Explore?v=rs6906846;vdb=variation
#	  	 https://www.ncbi.nlm.nih.gov/projects/SNP/snp_ref.cgi?rs=6906846
#          
#         American     AMR    
#         African      AFR
#         European     EUR
#         South Asian  SAS
#         East Asian   EAS
# Output: A whitespace-delimited .txt file with ten columns as below.
#         #chrom position rsid A1 A2 AMR AFR EUR SAS EAS
#-----------------------------------------------------------------------------------
export IN_FILE=iAdmix.reference.1000Gphase3snp.hg19.txt
export OUT_FILE=iAdmix.reference.1000Gphase3snp.hg38.txt
export REF_CHAIN=/mnt/data/UCSC/overchain/hg19ToHg38.over.chain

# Convert iAdmix reference .txt format file (produced by running 
#         create_iAdmix_referencedata_hg19.sh) to .bed format
awk '{  OFS="\t"; if(NR > 1) print "chr"$1,$2-1,$2,$3";"$4";"$5";"$6";"$7";"$8";"$9";"$10 }' \
    $IN_FILE  > $IN_FILE.bed 

# Map hg19 positions to hg38 positions using liftOver and .over.chain file  
#   Download liftOver execution file from UCSC  (requires log-in and agreement)
#       https://genome-store.ucsc.edu/
#   Install libpng12, a dependent linux package, before running liftOver.
#       sudo yum install libpng12
#   Download liftOver chain files from UCSC
#      (http://hgdownload.cse.ucsc.edu/goldenpath/hg19/liftOver/)
liftOver $IN_FILE.bed $REF_CHAIN $OUT_FILE.bed $OUT_FILE.unmapped 

# Convert .bed output file (generaed by liftOver) to iAdmix reference .txt format
echo -e "#chrom position rsid A1 A2 AMR AFR EUR SAS EAS" > $OUT_FILE
awk '{ split($4, a, ";"); print $1,$3,a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8] }' \
	$OUT_FILE.bed | \
	sed 's/^chr//g' >>  $OUT_FILE
