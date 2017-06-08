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


#-------------------------------------------------------------------------------------------
# NA1287_GIAB
#-------------------------------------------------------------------------------------------
cd /scratch/iAdmixResults/testrun

export REF_FREQ=/opt/ancestry/hapmap3.8populations.hg19.txt 
export PLINK_PREFIX=NA12878_GIAB_hg19
export OUTPUT_PREFIX=NA12878_GIAB_8populations_hg19 


python /opt/ancestry/runancestry.py --freq=${REF_FREQ} \
 --path=/opt/ancestry --plink=${PLINK_PREFIX} --out=${OUTPUT_PREFIX}

grep -w "final maxval"  ${OUTPUT_PREFIX}.INTEGRATION.input.ancestry | \
 awk -F ' ADMIX_PROP ' '{ print $2 }' | sed -e 's/[0-9\.\:]//g' > ${OUTPUT_PREFIX}.af.txt 


grep -w "final maxval"  ${OUTPUT_PREFIX}.INTEGRATION.input.ancestry  | \
 awk -F ' ADMIX_PROP ' '{ print $2 }' | sed -e 's/[A-Za-z\:]//g' >> ${OUTPUT_PREFIX}.af.txt 


#-------------------------------------------------------------------------------------------
# 100PilotCases on hapmap3 hg18
#-------------------------------------------------------------------------------------------
cd /scratch/iAdmixResults/100PilotCases/hg18

export PLINK_PREFIX=100PilotCases_hg18
export REF_FREQ=/opt/ancestry/hapmap3.8populations.hg18.txt 
export AGGREGATE_AF_PREFIX=8populations_hg18


export OUTPUT_PREFIX=${AGGREGATE_AF_PREFIX}/${AGGREGATE_AF_PREFIX}
export OUT_FILE=${AGGREGATE_AF_PREFIX}.af.txt
mkdir ${AGGREGATE_AF_PREFIX}

python /opt/ancestry/runancestry.py --freq=${REF_FREQ} \
 --path=/opt/ancestry --plink=${PLINK_PREFIX} --out=${OUTPUT_PREFIX}


echo -e "reference sample YRI CHB CHD TSI MKK LWK CEU JPT" > ${OUT_FILE}

grep -w "final maxval" ${OUTPUT_PREFIX}*.input.ancestry | \
  awk -F ':' '{split($1,a,"."); print ${AGGREGATE_AF_PREFIX},a[2], $3,$4,$5,$6,$7,$8,$9,$10}' | \
  cut -d ' ' -f1,2,3,5,7,9,11,13,15,17 >> ${${OUT_FILE}} 



# spot check based on the phenotype file
#   head /mnt/data/max/100PilotCases/GTarray/bird2ped/normalCaseMeta.csv 

# Asian 
#   YRI:0.0000 CHB:0.0806 CHD:0.2981 TSI:0.0000 MKK:0.1879 LWK:0.4335 CEU:0.0000 JPT:0.0000
grep -w "final maxval"  ${OUTPUT_PREFIX}.146c5332-1af5-4c49-b740-9a9edc795f24.input.ancestry | \
 awk -F ' ADMIX_PROP ' '{ print $2 }' 

# White 
#  YRI:0.0000 CHB:0.0554 CHD:0.2858 TSI:0.0201 MKK:0.1896 LWK:0.4491 CEU:0.0000 JPT:0.0000 
grep -w "final maxval"  ${OUTPUT_PREFIX}.1d25c24e-bd3c-4023-85c1-b158f76324f1.input.ancestry | \
 awk -F ' ADMIX_PROP ' '{ print $2 }' 

# Black
#. YRI:0.0000 CHB:0.0000 CHD:0.2682 TSI:0.0000 MKK:0.3104 LWK:0.4214 CEU:0.0000 JPT:0.0000
grep -w "final maxval"  ${OUTPUT_PREFIX}.16ac4341-cf8f-45e2-b90b-2d12d5f74a59.input.ancestry | \
 awk -F ' ADMIX_PROP ' '{ print $2 }' 




#-------------------------------------------------------------------------------------------
# 100PilotCases on 1000Genomes  hg18
#-------------------------------------------------------------------------------------------
cd /scratch/iAdmixResults/100PilotCases/hg18

export PLINK_PREFIX=100PilotCases_hg18
export REF_FREQ=/opt/ancestry/1000Gphase3Subset250K.5superpopulations.hg18.txt
export AGGREGATE_AF_PREFIX=5superpopulationsSubset250K_hg18


export OUTPUT_PREFIX=${AGGREGATE_AF_PREFIX}/${AGGREGATE_AF_PREFIX}
export OUT_FILE=${AGGREGATE_AF_PREFIX}.af.txt
mkdir ${AGGREGATE_AF_PREFIX}

python /opt/ancestry/runancestry.py --freq=${REF_FREQ} \
 --path=/opt/ancestry --plink=${PLINK_PREFIX} --out=${OUTPUT_PREFIX}


echo -e "reference sample AFR AMR EAS EUR SAS" > ${OUT_FILE}

grep -w "final maxval" ${OUTPUT_PREFIX}*.input.ancestry | \
  awk -F ':' '{split($1,a,"."); print "5superpopulationsSubset250K",a[2],$3,$4,$5,$6,$7}' | \
  cut -d ' ' -f1,2,3,5,7,9,11 >> ${OUT_FILE} 


# Asian 
#   YRI:0.0000 CHB:0.0806 CHD:0.2981 TSI:0.0000 MKK:0.1879 LWK:0.4335 CEU:0.0000 JPT:0.0000
#   AFR:1.0000 AMR:0.0000 EAS:0.0000 EUR:0.0000 SAS:0.0000
grep -w "final maxval"  ${OUTPUT_PREFIX}.146c5332-1af5-4c49-b740-9a9edc795f24.input.ancestry | \
 awk -F ' ADMIX_PROP ' '{ print $2 }' 

# White 
#  YRI:0.0000 CHB:0.0554 CHD:0.2858 TSI:0.0201 MKK:0.1896 LWK:0.4491 CEU:0.0000 JPT:0.0000 
#  AFR:0.7924 AMR:0.0000 EAS:0.2076 EUR:0.0000 SAS:0.0000 
grep -w "final maxval"  ${OUTPUT_PREFIX}.1d25c24e-bd3c-4023-85c1-b158f76324f1.input.ancestry | \
 awk -F ' ADMIX_PROP ' '{ print $2 }' 

# Black
#  YRI:0.0000 CHB:0.0000 CHD:0.2682 TSI:0.0000 MKK:0.3104 LWK:0.4214 CEU:0.0000 JPT:0.0000
#  AFR:0.7228 AMR:0.0000 EAS:0.2772 EUR:0.0000 SAS:0.0000 
grep -w "final maxval"  ${OUTPUT_PREFIX}.16ac4341-cf8f-45e2-b90b-2d12d5f74a59.input.ancestry | \
 awk -F ' ADMIX_PROP ' '{ print $2 }' 











