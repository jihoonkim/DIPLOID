

# Asian
# CaseID = 146c5332-1af5-4c49-b740-9a9edc795f24
# HapMap3
#    YRI:0.000000 CHB:0.446826 CHD:0.164529 TSI:0.000000 MKK:0.000000 LWK:0.000000 CEU:0.000000 JPT:0.388645
# 1000 genome
#    AFR:0.000000 AMR:0.126999 EAS:0.873001 EUR:0.000000 SAS:0.000000 



python   /opt/ancestry/runancestry.py  --freq=/opt/ancestry/hapmap3.8populations.hg18.txt  --cores=4 \
  --path=/opt/ancestry --plink=146c5332-1af5-4c49-b740-9a9edc795f24  --out=test_hapmap3 

python   /opt/ancestry/runancestry.py  --freq=/opt/ancestry/swap.txt  --cores=4 \
  --path=/opt/ancestry --plink=146c5332-1af5-4c49-b740-9a9edc795f24  --out=test_1000G





# White 
# CaseID = 1d25c24e-bd3c-4023-85c1-b158f76324f1 
# HapMap3
#    YRI:0.000000 CHB:0.000000 CHD:0.000000 TSI:0.205281 MKK:0.000000 LWK:0.000000 CEU:0.794719 JPT:0.000000 
# 1000 genome
#    AFR:0.094858 AMR:0.078570 EAS:0.000000 EUR:0.826573 SAS:0.000000

python   /opt/ancestry/runancestry.py  --freq=/opt/ancestry/hapmap3.8populations.hg18.txt  --cores=4 \
  --path=/opt/ancestry --plink=1d25c24e-bd3c-4023-85c1-b158f76324f1 --out=test_hapmap3 

python   /opt/ancestry/runancestry.py  --freq=/opt/ancestry/swap.txt  --cores=4 \
  --path=/opt/ancestry --plink=1d25c24e-bd3c-4023-85c1-b158f76324f1  --out=test_1000G




# Black
# CaseID = 16ac4341-cf8f-45e2-b90b-2d12d5f74a59
# HapMap3
#   YRI:0.629484 CHB:0.000000 CHD:0.000000 TSI:0.093997 MKK:0.000000 LWK:0.207611 CEU:0.068907 JPT:0.000000
# 1000 genome
#   AFR:1.000000 AMR:0.000000 EAS:0.000000 EUR:0.000000 SAS:0.000000

python   /opt/ancestry/runancestry.py  --freq=/opt/ancestry/hapmap3.8populations.hg18.txt  --cores=4 \
  --path=/opt/ancestry --plink=16ac4341-cf8f-45e2-b90b-2d12d5f74a59 --out=test_hapmap3 

python   /opt/ancestry/runancestry.py  --freq=/opt/ancestry/swap.txt  --cores=4 \
  --path=/opt/ancestry --plink=16ac4341-cf8f-45e2-b90b-2d12d5f74a59  --out=test_1000G



