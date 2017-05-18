#-----------------------------------------------------------------------------------
# Filename: run.sh
# Author: Jihoon Kim
# Email:  j5kim@ucsd.edu
# Description: Creates iAdmix reference data in three diffrent versions;
#              hg18, hg19, and hg38.
#
#              For example,
#              rs6906846      hg19 6:31245736  --->  hg18 6:31353715
#              rs6906846      hg19 6:31245736  --->  hg38 6:31277959
# Input: A whitespace-delimited .txt file with ten columns as below.
#         #chrom position rsid A1 A2 AMR AFR EUR SAS EAS
#         6 31245736 rs6906846 A G 0.7411 0.6787 0.6256 0.6899 0.6748
#        http://www.ensembl.org/Homo_sapiens/Variation/Population?db=core;v=rs6906846;vdb=variation
#          
#         African      AFR
#         American     AMR    
#         East Asian   EAS
#         European     EUR
#         South Asian  SAS
#
#		  Reference data file required as input to the UCSC liftOver utility.
#           $ head -n 5 hg19ToHg38.over.chain 
#			chain 20851231461 chr1 249250621 + 10000 249240621 chr1 248956422 + 10000 248946422 2
#			167376  50041   80290
#			40302   253649  288020
#			1044699 1       2
#			3716    0       3
#
#
# Output: A whitespace-delimited .txt file with ten columns as below.
#         #chrom position rsid A1 A2 AFR AMR EAS EUR SAS 
#-----------------------------------------------------------------------------------
# download UCSC liftOver chain files 
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/liftOver/hg19ToHg18.over.chain.gz
wget http://hgdownload.cse.ucsc.edu/goldenPath/hg19/liftOver/hg19ToHg38.over.chain.gz
gunzip *.over.chain.gz

# download 1000 genomes vcf file (hg19)
wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5b.20130502.sites.vcf.gz
gunzip ALL.wgs*.vcf.gz

# create an iAdmix reference data (hg19) from 1000 genomes vcf file
python create_iAdmix_referencedata.py -i  ALL.wgs.phase3_shapeit2_mvncall_integrated_v5b.20130502.sites.vcf > 1000Gphase3.5superpopulations.hg19.txt

# convert iAdmix reference data hg19 to hg18
bash convert_hg19_to_hg18_iAdmix_reference.sh

# convert iAdmix reference data hg19 to hg38
bash convert_hg19_to_hg38_iAdmix_reference.sh

