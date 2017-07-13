sudo mkdir hapmap3_8populations_hg38
sudo chown j5kim:j5kim hapmap3_8populations_hg38

# run iAdmix in parallel with HapMap3 
#cd /scratch/WXS/PLINK/individual
#parallel 'bash run_hapmap3.sh {}'  ::: *.ped 
bash run_hapmap3.sh WXS.snps 

# Create a report for HapMap3
cd /scratch/WXS/hapmap3_8populations_hg38

export REPORT_AGGREGATE_FILE=/scratch/report/WXS_hapmap3_8populations_hg38.txt

grep -w "final maxval"  *.ancestry | awk -F ' ADMIX_PROP ' '{ print $2 }' | \
  head -n 1 | sed -e 's/[0-9\:\.]//g' > ${REPORT_AGGREGATE_FILE}
sed -i 's/^/reference sample /' ${REPORT_AGGREGATE_FILE}

#grep -w "final maxval"  *.input.ancestry | \
#  awk -F ':' '{split($1,a,"."); print a[1],a[2], $3,$4,$5,$6,$7,$8,$9,$10}' | \
#  cut -d ' ' -f1,2,3,5,7,9,11,13,15,17 >> /scratch/report/WXS_hapmap3_8populations_hg38.txt
grep -w "final maxval"  *.ancestry | awk -F ' ADMIX_PROP ' '{ print $1 }' | awk -F '.' '{ print $1,$2 }' > left.tmp
grep -w "final maxval"  *.ancestry | awk -F ' ADMIX_PROP ' '{ print $2 }' | sed -e 's/[A-Za-z\:]//g'  > right.tmp
paste left.tmp right.tmp | column -s $'\t' -t >> ${REPORT_AGGREGATE_FILE}
rm *.tmp




#-----------------------------------------------------------------------------------------
#
# 1000 genome
#
#-----------------------------------------------------------------------------------------
# Create directories
cd /scratch/WXS
sudo mkdir 1000Gphase3_5superpopulations_hg38
sudo chown j5kim:j5kim  1000Gphase3_5superpopulations_hg38


# Run iAdmix individually
#bash run_1000G.sh 018f93ad-92ef-4bbb-a0fb-dc407a289daa
#parallel --dryrun -a individuals.txt 'bash run_1000G.sh {}' 

cd /scratch/WXS/PLINK
bash run_1000G.sh WXS.snps 


  # Create a report for 1000G


cd /scratch/WXS/1000Gphase3_5superpopulations_hg38
export REPORT_AGGREGATE_FILE=/scratch/report/WXS_1000Gphase3_5superpopulations_hg38.txt

grep -w "final maxval"  *.ancestry | awk -F ' ADMIX_PROP ' '{ print $2 }' | \
  head -n 1 | sed -e 's/[0-9\:\.]//g' > ${REPORT_AGGREGATE_FILE}
sed -i 's/^/reference sample /' ${REPORT_AGGREGATE_FILE}


#grep -w "final maxval"  *.ancestry | \
#  awk -F ':' '{split($1,a,"."); print a[1],a[2], $3,$4,$5,$6,$7,$8,$9,$10}' | \
#  cut -d ' ' -f1,2,3,5,7,9,11,13,15,17 >> WXS_1000Gphase3_5superpopulations_hg38.txt
grep -w "final maxval"  *.ancestry | awk -F ' ADMIX_PROP ' '{ print $1 }' | awk -F '.' '{ print $1,$2 }' > left.tmp
grep -w "final maxval"  *.ancestry | awk -F ' ADMIX_PROP ' '{ print $2 }' | sed -e 's/[A-Za-z\:]//g'  > right.tmp
paste left.tmp right.tmp | column -s $'\t' -t >> WXS_1000Gphase3_5superpopulations_hg38.txt
rm *.tmp




