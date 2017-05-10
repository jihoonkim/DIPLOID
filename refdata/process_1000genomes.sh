#-----------------------------------------------------------------------------------
# Filename: process_1000genomes.sh
# Author: Jihoon Kim
# Email:  j5kim@ucsd.edu
# Description: Create a reference data to be used in iAdmix. Collect allele 
#              frequencies of five continental superpopulations from the vcf files
#              of 1000 Genomes Project (Phase 3).
#                iAdmix (https://github.com/vibansal/ancestry)
#
#              Create 10-column files delimted by whitespace as below. 
#              #chrom position rsid A1 A2 EAS SAS AFR EUR AMR 
#              1 566875 rs2185539 T C 0.07 0.02 0.04 0.63 0.02
#
#              East Asian   EAS
#              South Asian  SAS
#              African      AFR
#              European     EUR
#              American     AMR                  
#-----------------------------------------------------------------------------------
# set a source repository FTP site
export SRC_FTP_SITE="ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/"

# recursively download all .gz files in above FTP site
wget -A gz -r -l 1 -nd $SRC_FTP_SITE 

# extract all .gz files
gunzip *.gz

# select only single nucleotide variants (SNVs)