cp 1000Gphase3_5superpopulations_hg38.txt backup_1000Gphase3_5superpopulations_hg38.txt

tail -n  +2 backup_1000Gphase3_5superpopulations_hg38.txt > body.txt

sort -k1,1 -k2,2n body.txt > sortedbody.txt

grep -v 'alt\|random\|Un\|,' sortedbody.txt  > removeNoncanonicalChrom.txt 



echo -e "#chrom position rsid A1 A2 AFR AMR EAS EUR SAS" > 1000Gphase3_5superpopulations_hg38.txt

cat removeNoncanonicalChrom.txt >> 1000Gphase3_5superpopulations_hg38.txt


grep -w "rs2185539\|rs3131972\|rs6906846"  1000Gphase3.5superpopulations.hg38.txt


#grep -w "rs2185539\|rs3131972\|rs6906846"  ALL.wgs.phase3_shapeit2_mvncall_integrated_v5b.20130502.sites.vcf