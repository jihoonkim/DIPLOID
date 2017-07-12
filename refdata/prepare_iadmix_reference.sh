cp 1000Gphase3_5superpopulations_hg38.txt backup_1000Gphase3_5superpopulations_hg38.txt

tail -n  +2 backup_1000Gphase3_5superpopulations_hg38.txt > body.txt

sort -k1,1 -k2,2n body.txt > sortedbody.txt

grep -v 'alt\|random\|Un' sortedbody.txt  > removeNoncanonicalChrom.txt 

awk '{ print $1,$2,$3,$5,$4,$6,$7,$8,$9,$10 } ' removeNoncanonicalChrom.txt  > swapA1A2.txt 


echo -e "" > 1000Gphase3_5superpopulations_hg38.txt
cat swapA1A2.txt >> 1000Gphase3_5superpopulations_hg38.txt
