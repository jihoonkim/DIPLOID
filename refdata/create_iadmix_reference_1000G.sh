#-----------------------------------------------------------------------------------
# Filename: create_iadmix_reference_1000G.sh
# Author: Jihoon Kim
# Email:  j5kim@ucsd.edu
# Description: Create an iAdmix reference files for three different genome builds
#              from 1000G vcf file.
#              For example,
#              rs6906846      hg19 6:31245736  --->  hg38 6:31277959
# Input: A whitespace-delimited .txt file with ten columns as below.
#         #chrom position rsid A1 A2 AMR AFR EUR SAS EAS
#         6 31245736 rs6906846 A G 0.6256 0.6787 0.7411 0.6899 0.6748
#        http://www.ensembl.org/Homo_sapiens/Variation/Population?db=core;v=rs6906846;vdb=variation
#          
#         African      AFR
#         American     AMR    
#         East Asian   EAS
#         European     EUR
#         South Asian  SAS
# Output: A whitespace-delimited .txt file with ten columns as below.
#         #chrom position rsid A1 A2 AFR AMR EAS EUR SAS
#-----------------------------------------------------------------------------------

# set parameters
export FTP_URL="ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/"
export INPUT_VCF_FILE="ALL.wgs.phase3_shapeit2_mvncall_integrated_v5b.20130502.sites.vcf"
export iAdmix_REF_hg19="1000Gphase3.5superpopulations.hg19.txt"
export iAdmix_REF_hg18="1000Gphase3.5superpopulations.hg18.txt"
export iAdmix_REF_hg38="1000Gphase3.5superpopulations.hg38.txt"
export LIFTOVER_hg19Tohg38="hg19ToHg38.over.chain"
export LIFTOVER_hg19Tohg18="hg19ToHg18.over.chain"
export OUTPUT_HEADER="#chrom position rsid A1 A2 AFR AMR AS EUR SAS"

# download 1000 genomes vcf file (hg19)
wget ${FTP_URL}/${INPUT_VCF_FILE}.gz
gunzip ${INPUT_VCF_FILE}.gz

#--------------------------------------------------------------------------------------
# Output hg19 version
#--------------------------------------------------------------------------------------
python convert_vcf2txt_1000G.py -i ${INPUT_VCF_FILE} > ${iAdmix_REF_hg19}


#--------------------------------------------------------------------------------------
# Output hg18 version
#--------------------------------------------------------------------------------------
# Create a .bed file to be used for liftOver
#         create_iAdmix_referencedata_hg19.sh) to .bed format
awk '{  OFS="\t"; if(NR > 1) print "chr"$1,$2-1,$2,$3";"$4";"$5";"$6";"$7";"$8";"$9";"$10 }' \
    ${iAdmix_REF_hg19}  > ${iAdmix_REF_hg19}.bed 

# Map hg19 positions to hg18 positions using liftOver and .over.chain file  
#   Download liftOver execution file from UCSC  (requires log-in and agreement)
#       https://genome-store.ucsc.edu/
#   Install libpng12, a dependent linux package, before running liftOver.
#       sudo yum install libpng12
#   Download liftOver chain files from UCSC
#      (http://hgdownload.cse.ucsc.edu/goldenpath/hg19/liftOver/)
liftOver ${iAdmix_REF_hg19}.bed ${LIFTOVER_hg19Tohg18} \
  ${iAdmix_REF_hg18}.bed ${iAdmix_REF_hg18}.unmapped 

# Convert .bed output file (generaed by liftOver) to iAdmix reference .txt format
#echo ${OUTPUT_HEADER} > ${iAdmix_REF_hg18}
#awk '{ split($4, a, ";"); print $1,$3,a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8] }' \
#  	  ${iAdmix_REF_hg18}.bed | \
#    sed 's/^chr//g' >>  ${iAdmix_REF_hg18}
echo ${OUTPUT_HEADER} > ${iAdmix_REF_hg18}
#sed 's/^chr//g' ${iAdmix_REF_hg18}.bed |  \
#   sed $'s/;/\t/g' | cut -f1,3,4,5,6,7- | sort -k1,1 -k2,2n >>  ${iAdmix_REF_hg18}

sed $'s/\t/ /g'  ${iAdmix_REF_hg18}.bed |  sed $'s/;/ /g' | \
 cut -d ' ' -f1,3,4,5,6,7- | sed 's/^chr//g' > ${iAdmix_REF_hg18}.unsorted 

sort -k1,1 -k2,2n  ${iAdmix_REF_hg18}.unsorted  >> ${iAdmix_REF_hg18}


#--------------------------------------------------------------------------------------
# Output hg38 version
#--------------------------------------------------------------------------------------
# Map hg19 positions to hg38 positions using liftOver and .over.chain file  
#   Download liftOver execution file from UCSC  (requires log-in and agreement)
#       https://genome-store.ucsc.edu/
#   Install libpng12, a dependent linux package, before running liftOver.
#       sudo yum install libpng12
#   Download liftOver chain files from UCSC
#      (http://hgdownload.cse.ucsc.edu/goldenpath/hg19/liftOver/)
liftOver ${iAdmix_REF_hg19}.bed ${LIFTOVER_hg19Tohg38} \
  ${iAdmix_REF_hg38}.bed ${iAdmix_REF_hg38}.unmapped 

# Convert .bed output file (generaed by liftOver) to iAdmix reference .txt format
echo ${OUTPUT_HEADER} > ${iAdmix_REF_hg38}
#sed 's/^chr//g' ${iAdmix_REF_hg18}.bed |  \
#   sed $'s/;/\t/g' | cut -f1,3,4,5,6,7- | sort -k1,1 -k2,2n >>  ${iAdmix_REF_hg18}

sed $'s/\t/ /g'  ${iAdmix_REF_hg38}.bed |  sed $'s/;/ /g' | \
 cut -d ' ' -f1,3,4,5,6,7- | sed 's/^chr//g' | \
 sort -k1,1 -k2,2n >> ${iAdmix_REF_hg38}
