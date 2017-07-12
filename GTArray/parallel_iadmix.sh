#!/bin/bash
FIRSTLETTER=$1
CPUNUM=$2

# Batch run of iAdmix 
export iADMIX_DIR=/opt/ancestry
export RESOURCE_DATA=${iADMIX_DIR}/1000Gphase3Subset250K.5superpopulations.hg18.txt
export OUTPUT_DIR=/scratch/GTarray/output_1000G_${FIRSTLETTER}

mkdir -p ${OUTPUT_DIR}

for i in ${FIRSTLETTER}*.ped
do
  PREFIX=`basename $i .ped`
  # compute population allele frequencies 
  python    ${iADMIX_DIR}/runancestry.py  --freq=${RESOURCE_DATA} --cores=24 --modcore=${CPUNUM} \
    --path=${iADMIX_DIR} --plink=${PREFIX} --out=${OUTPUT_DIR}/${PREFIX} 
done


