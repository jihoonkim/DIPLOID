cd /scratch/WXS/PLINK

# Output a new vcf file from the input vcf file that removes any indel sties
#vcftools --vcf ../FromMax/combined.annotated.vcf --chr chr21 --remove-indels --recode --recode-INFO-all --out chr21

# Output a new vcf file from the input vcf file that removes any indel sties
vcftools --vcf ../FromMax/combined.annotated.vcf --remove-indels --recode --recode-INFO-all --out WXS.snps.vcf 


# Convert .vcf to PLINK format (.ped and .map)
vcftools --vcf WXS.snps.vcf --plink  --out WXS.snps




# Create individual PLINK files
awk '{ print $1 }' WXS.snps.ped > individuals.txt 

#head -n 1 individuals.txt > mylist.txt

cat individuals.txt  | while read i 
do
  echo -e "${i} ${i}" > individual/${i}.id
  plink --file WXS.snps --recode  --keep individual/${i}.id \
       --out individual/${i} --noweb
done 









sudo mkdir hapmap3_8populations_hg38
sudo chown j5kim:j5kim hapmap3_8populations_hg38

bash run_hapmap3.sh WXS.snps 



sudo mkdir 1000Gphase3_5superpopulations_hg38
sudo chown j5kim:j5kim  1000Gphase3_5superpopulations_hg38




bash run_1000G.sh 018f93ad-92ef-4bbb-a0fb-dc407a289daa


parallel --dryrun -a individuals.txt 'bash run_1000G.sh {}' 



bash run_1000G.sh WXS.snps 






# Create a report for HapMap3
echo -e "reference sample YRI CHB CHD TSI MKK LWK CEU JPT" > WXS_hapmap3_8populations_hg38.txt

grep -w "final maxval"  hapmap3_8populations_hg38.f*.input.ancestry | \
  awk -F ':' '{split($1,a,"."); print a[1],a[2], $3,$4,$5,$6,$7,$8,$9,$10}' | \
  cut -d ' ' -f1,2,3,5,7,9,11,13,15,17 >> WXS_hapmap3_8populations_hg38.txt