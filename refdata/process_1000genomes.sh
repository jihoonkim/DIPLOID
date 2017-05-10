#-----------------------------------------------------------------------------------
# Filename: process_1000genomes.sh
# Author: Jihoon Kim
# Email:  j5kim@ucsd.edu
# Description: Create a reference set of allele frequencies of five continental
#              super population from the vcf files of 1000 Genomes Project (Phase 3)
#-----------------------------------------------------------------------------------
# set a source repository FTP site
export SRC_FTP_SITE="ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502/"

# recursively download all .gz files in above FTP site
wget -A gz -r -l 1 -nd $SRC_FTP_SITE 