#!/bin/bash


cd /scratch/GTarray



# create symbolic links for a common PLINK .map file
for i in *.ped
do
  PREFIX=`basename $i .ped`
  ln -s ../plink.map $PREFIX.map
done




#!/bin/bash
FIRSTLETTER=$1
CPUNUM=$2

# Batch run of iAdmix 
export iADMIX_DIR=/opt/ancestry
export RESOURCE_DATA=${iADMIX_DIR}/1000Gphase3Subset250K.5superpopulations.hg18.txt
export OUTPUT_DIR=/scratch/GTarray/1000Gphase3Subset250K.5superpopulations.hg18

for i in ${FIRSTLETTER}*.ped
do
  PREFIX=`basename $i .ped`
  # compute population allele frequencies 
  python    ${iADMIX_DIR}/runancestry.py  --freq=${RESOURCE_DATA} --cores=24 --modcore=${CPUNUM} \
    --path=${iADMIX_DIR} --plink=${PREFIX} --out=${OUTPUT_DIR}/${PREFIX} 
done








### Merge all samples into a single large PLINK ped/map file
#plink --file 0004d251-3f70-4395-b175-c94c2f5b1b81 --merge-list AllButOnePLINKfiles.txt \
# --recode --out GTarray --noweb 




# known Asian 
ln -s ../plink.map 146c5332-1af5-4c49-b740-9a9edc795f24.map 


python /opt/ancestry/runancestry.py  --freq=/opt/ancestry/hapmap3.8populations.hg18.txt  --cores=24 \
  --path=/opt/ancestry --plink=146c5332-1af5-4c49-b740-9a9edc795f24 --out=test_hapmap3 

python   /opt/ancestry/runancestry.py  --freq=/opt/ancestry/1000Gphase3Subset250K.5superpopulations.hg18.txt  \
  --path=/opt/ancestry --plink=146c5332-1af5-4c49-b740-9a9edc795f24 --out=test_1000G




# Parallelize 
#ls *.ped | cut -c1 | sort | uniq >  firstletters.txt
#parallel -a firstletters.txt 'bash parallel_iadmix.sh {}' 
parallel 'bash parallel_iadmix.sh {}' ::: {0..9} a b c d e f  

parallal  sed -i s'/.$/\n/' {} ::: *.ped


ls output_1000G_0/*.ancestry | wc -l 

# report iAdmix output
find output_1000G_* -maxdepth 1 -type f  -name '*.ancestry' | wc -l

