#-----------------------------------------------------------------------------------
# Filename: create_iAdmix_referencedata_hg19.sh
# Author: Jihoon Kim
# Email:  j5kim@ucsd.edu
# Description: Create a reference data to be used in iAdmix. 
#              (https://github.com/vibansal/ancestry)
# Input: A .vcf file of allele frequencies from five continental superpopulations 
#        in 1000 Genomes Project (Phase 3)
#        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502
#        Exmple single row in .vcf file
#        6	31245736	rs6906846	A	G	100	PASS	
#        AC=3399;AF=0.678714;AN=5008;NS=2504;DP=18618;EAS_AF=0.7411;AMR_AF=0.6787;
#        AFR_AF=0.6256;EUR_AF=0.6899;SAS_AF=0.6748;AA=a|||;VT=SNP
# Output: A whitespace-delimited .txt file with ten columns as below.
#         #chrom position rsid A1 A2 AMR AFR EUR SAS EAS
#         6 31245736 rs6906846 A G 0.7411 0.6787 0.6256 0.6899 0.6748
#         African      AFR
#         American     AMR    
#         East Asian   EAS
#         European     EUR
#         South Asian  SAS
#-----------------------------------------------------------------------------------
export FTP_SITE="ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/"
export INPUT_VCF="ALL.wgs.phase3_shapeit2_mvncall_integrated_v5b.20130502.sites.vcf"
export OUTPUT_TXT="iAdmix.reference.1000Gphase3snp.hg19.txt"

# download a vcf file from 1000 Genomes Phase 3
#wget ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/ALL.wgs.phase3_shapeit2_mvncall_integrated_v5b.20130502.sites.vcf.gz 
#gunzip ALL.wgs.phase3_shapeit2_mvncall_integrated_v5b.20130502.sites.vcf.gz
wget $FTP_SITE$INPUT_VCF
gunzip $INPUT_VCF.gz


# select single nucleotide polymorphisms (SNPs) to create iAdmix compatible reference data
#              #chrom position rsid A1 A2 EAS SAS AFR EUR AMR 
#              1 566875 rs2185539 T C 0.07 0.02 0.04 0.63 0.02
#echo -e "#chrom position rsid A1 A2 AFR AMR EAS EUR SAS"       | \
#     >  iAdmix.reference.1000Gphase3snp.hg19.txt 
#grep "VT=SNP" ALL.wgs.phase3_shapeit2_mvncall_integrated_v5b.20130502.sites.vcf  | \
#     awk '{ split($8, a, ";"); print $1,$2,$3,$4,$5,a[6],a[7],a[8],a[9],a[10] }' | \
#     sed 's/AMR_AF=//g;s/AFR_AF=//g;s/EUR_AF=//g;s/SAS_AF=//g;s/EAS_AF=//g'      | \
#     >> iAdmix.reference.1000Gphase3snp.hg19.txt 
echo -e "#chrom position rsid A1 A2 AFR AMR EAS EUR SAS"   > $OUTPUT_TXT
python create_iAdmix_referencedata.py -i $INPUT_VCF          >> $OUTPUT_TXT