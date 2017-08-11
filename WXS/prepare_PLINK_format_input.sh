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









