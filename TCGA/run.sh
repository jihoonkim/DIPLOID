#-----------------------------------------------------------------------------------
# Filename: run.sh
# Author: Jihoon Kim
# Email:  j5kim@ucsd.edu
# Description: Run iAdmix to compute the population allele frequency
#-----------------------------------------------------------------------------------
# set the input parameters
export iADMIX_DIR=/opt/ancestry
export RESOURCE_DATA=${iADMIX_DIR}/iAdmix.reference.1000Gphase3snp.hg19.txt
export INPUT_PREFIX=discovery

### compute population allele frequencies 
python    ${iADMIX_DIR}/runancestry.py  --freq  ${RESOURCE_DATA} \
  --path=${iADMIX_DIR} --plink ${INPUT_PREFIX} --out ${INPUT_PREFIX} 

### parse and integrate individual-level output into a single file.
