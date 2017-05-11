#-----------------------------------------------------------------------------------
# Filename: create_iAdmix_referencedata.py
# Author: Jihoon Kim
# Email:  j5kim@ucsd.edu
# Description: Create a reference data to be used in iAdmix. 
#              (https://github.com/vibansal/ancestry)
# Input: A .vcf file of allele frequencies from five continental superpopulations 
#        (in a random order) in 1000 Genomes Project (Phase 3)
#        ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/release/20130502
#        Exmple single row in .vcf file
#        6	31245736	rs6906846	A	G	100	PASS	
#        AC=3399;AF=0.678714;AN=5008;NS=2504;DP=18618;EAS_AF=0.7411;AMR_AF=0.6787;
#        AFR_AF=0.6256;EUR_AF=0.6899;SAS_AF=0.6748;AA=a|||;VT=SNP
#        http://www.ensembl.org/Homo_sapiens/Variation/Explore?v=rs6906846;vdb=variation
#	  	 https://www.ncbi.nlm.nih.gov/projects/SNP/snp_ref.cgi?rs=6906846
# Output: A whitespace-delimited .txt file with ten columns in a sorted order of
#         African      AFR
#         American     AMR    
#         East Asian   EAS
#         European     EUR
#         South Asian  SAS
#         #chrom position rsid A1 A2 AMR AFR EUR SAS EAS
#         6 31245736 rs6906846 A G 0.7411 0.6787 0.6256 0.6899 0.6748
#-----------------------------------------------------------------------------------
import getopt, re, sys

def get_superpopulation_allele_frequency( inputfile ):
	with open(inputfile) as fh:
		for line in fh:
			# Skip the comments in the header
			if ( line.startswith("#") ):
				continue

			# Skip if the variant type is not SNP
			if ( line.find("VT=SNP") < 0 ): 
				continue

			# Collect the first 5 columns for output (chrom position rsid A1 A2)
			line = line.rstrip().split("\t")
			record = line[0] + ' ' + line[1] + ' ' + line[2] + ' ' + line[3] + ' ' + line[4]

			# Create a dictionary with super-population as a key and freq as a value
			# This is because input vcf files has randomly ordered allele frequencies
			arr = line[7].split(";")
			freqdict = dict()
			for i in arr:
				pair = i.split("=")
				if( len(pair)== 2 ):
					freqdict[ pair[0] ] = pair[1]
			
			# if all five allele frequencies of superpopulations exist, print them
			if freqdict.has_key("AFR_AF") & freqdict.has_key("AMR_AF") & freqdict.has_key("EAS_AF") & freqdict.has_key("EUR_AF") & freqdict.has_key("SAS_AF"):
				freq =  freqdict.get('AFR_AF') + ' ' + freqdict.get('AMR_AF') + ' ' + freqdict.get('EAS_AF') + ' ' + freqdict.get('EUR_AF') + ' ' + freqdict.get('SAS_AF') 
				record =  record + ' ' + freq 
				print record
			else:
				print "ERROR: MISSING AF " + line[0] + ' ' + line[1] + ' ' + line[2] + ' ' + line[7] 


def usage():
	print 'Usage: python create_iAdmix_referencedata.py -i <inputfile>'

def main(argv):
	inputfile = ''
	outputfile = ''
	try:
		opts, args = getopt.getopt( argv, "hi:",["ifile="] )
	except getopt.GetoptError:
		usage()
		sys.exit(2)
	for opt, arg in opts:
		if opt == '-h':
			usage()
			sys.exit()
		elif opt in ("-i", "--ifile"):
			inputfile = arg
	
	get_superpopulation_allele_frequency( inputfile )

if __name__ == "__main__":
   main(sys.argv[1:])
