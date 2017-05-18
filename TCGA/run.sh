#-----------------------------------------------------------------------------------
# Filename: run.sh
# Author: Jihoon Kim
# Email:  j5kim@ucsd.edu
# Description: Run iAdmix to compute the population allele frequency
#-----------------------------------------------------------------------------------
# set the input parameters
export iADMIX_DIR=/opt/ancestry
export RESOURCE_DATA=${iADMIX_DIR}/hapmap3.8populations.hg19.txt
export INPUT_PREFIX=discovery

### compute population allele frequencies 
python    ${iADMIX_DIR}/runancestry.py  --freq=${RESOURCE_DATA} --cores=4 \
  --path=${iADMIX_DIR} --plink=${INPUT_PREFIX} --out=${INPUT_PREFIX} 

### integrate individual-level inferred allele frequencies into a single file.
# head -n 1 $RESOURCE_DATA | cut -d ' ' -f 6-13 
echo -e "reference sample YRI CHB CHD TSI MKK LWK CEU JPT" > discovery_8populations.af.txt 
grep -w "final maxval" *.input.ancestry | awk -F ':' '{split($1,a,"."); print a[1],a[2], $3,$4,$5,$6,$7,$8,$9,$10}' | \
  cut -d ' ' -f1,2,3,5,7,9,11,13,15,17  >> discovery_8populations.af.txt 