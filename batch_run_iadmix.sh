#!/bin/bash

# set the input parameters
export iADMIX_DIR=/opt/ancestry
export RESOURCE_DATA=${iADMIX_DIR}/hapmap3.8populations.hg18.txt
export OUTPUT_DIR=/scratch/PLINK/hapmap3_8populations_hg18

for i in *.ped
do
  PREFIX=`basename $i .ped`
  # compute population allele frequencies 
  python    ${iADMIX_DIR}/runancestry.py  --freq=${RESOURCE_DATA} --cores=4 \
    --path=${iADMIX_DIR} --plink=${i} --out=${OUTPUT_DIR}/${i} 
done


echo -e "reference sample YRI CHB CHD TSI MKK LWK CEU JPT" > af.hapmap3_8populations_hg18.txt 
grep -w "final maxval" *.input.ancestry | awk -F ':' '{split($1,a,"."); print a[1],a[2], $3,$4,$5,$6,$7,$8,$9,$10}' | \
  cut -d ' ' -f1,2,3,5,7,9,11,13,15,17  >> af.hapmap3_8populations_hg18.txt