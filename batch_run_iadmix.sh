#!/bin/bash

# set the input parameters
export iADMIX_DIR=/opt/ancestry
export RESOURCE_DATA=${iADMIX_DIR}/hapmap3.8populations.hg18.txt
export OUTPUT_DIR=/scratch/PLINK/hapmap3_8populations_hg18

for i in *.ped
do
  PREFIX=`basename $i .ped`
  ### compute population allele frequencies 
  python    ${iADMIX_DIR}/runancestry.py  --freq=${RESOURCE_DATA} --cores=4 \
    --path=${iADMIX_DIR} --plink=${i} --out=${OUTPUT_DIR}/${i} 
done
