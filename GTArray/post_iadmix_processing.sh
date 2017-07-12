cd 1000Gphase3Subset250K.5superpopulations.hg18
echo -e "ReferencePanel CaseID AFR AMR EAS EUR SAS" > ../GTarray_1000G.txt 
grep -w "final maxval" *.ancestry | awk -F ':' '{split($1,a,"."); print a[1],a[2], $3,$4,$5,$6,$7,$8,$9,$10}' | \
  cut -d ' ' -f1,2,3,5,7,9,11,13,15,17 | \
  awk '{print "1000Gphase3Subset250K.5superpopulations.hg18",$2,$3,$4,$5,$6,$7}' >> ../ GTarray_1000G.txt



#  grep "final maxval" 4284a85d-d9b6-40ee-aac4-c2c03554528e.4284a85d-d9b6-40ee-aac4-c2c03554528e.input.ancestry |
 #awk -F ' ADMIX_PROP ' '{ print $2 }' | sed -e 's/[A-Za-z\:]//g' 

#echo -e "reference sample YRI CHB CHD TSI MKK LWK CEU JPT" > output.txt 
#grep -w "final maxval" 00a*.ancestry | awk -F ':' '{split($1,a,"."); print a[1],a[2], $3,$4,$5,$6,$7,$8,$9,$10}' | \
#  cut -d ' ' -f1,2,3,5,7,9,11,13,15,17  

