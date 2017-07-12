### update the repository source list 
#apt-get update -y 
yum check-update

### install dependent packages
#apt-get install -y  autoconf build-essential git g++ libncurses5-dev \
yum install -y \
 autoconf build-essential git g++ \
 libssl-dev make \
 ncurses-devel \
 pkg-config software-properties-common python vim \
 wget zip zlibc zlib1g zlib1g-dev 

### install vcftools to convert .vcf to PLINK format file
cd /opt
git clone https://github.com/vcftools/vcftools.git 
cd vcftools
./autogen.sh 
./configure 
make 
make install


### install iADMIX to compute population allele frequencies
cd /opt 
git clone https://github.com/vibansal/ancestry.git
cd ancestry
make all


### download resource data, the population allele frequencies for common SNPs
###  from the International HapMap project (ftp://ftp.ncbi.nlm.nih.gov/hapmap)
cd /opt/ancestry
wget https://raw.githubusercontent.com/jihoonkim/dockerhub-iadmix/master/hapmap3.8populations.hg19.zip
unzip hapmap3.8populations.hg19.zip
rm hapmap3.8populations.hg19.zip


### install PLINK
cd /opt
wget http://zzz.bwh.harvard.edu/plink/dist/plink-1.07-x86_64.zip
unzip plink-1.07-x86_64.zip
ln -s /opt/plink-1.07-x86_64/plink /usr/local/bin/plink 
