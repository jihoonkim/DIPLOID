def create_subset_ref(snpfile, reffile):
	#selectedSNPFile = "rsid.hapmap3.8populations.hg19.txt"
	selectedSNPs = set()
	with open(snpfile) as fh:
		for line in fh:
			line = line.rstrip('\n')
			selectedSNPs.add( line )

	header = "#chrom position rsid A1 A2 AFR AMR EAS EUR SAS"
	print header

	#refFile = "iAdmix.reference.1000Gphase3snp.hg19.txt"
	with open(reffile) as fh:
		for line in fh:
			line = line.rstrip('\n')
			arr = line.split() 
			
			# if the rsid is found in Bansal's 8 population reference,
			#  print the reference
			if( arr[2] in selectedSNPs ):
				print line

def usage():
	print 'Usage: python create_subset_refdata.py -r <referencefile> -s <snpfile>'

def main(argv):
	inputfile = ''
	outputfile = ''
	try:
		opts, args = getopt.getopt( argv, "hr:s:",["referencefile=","snpfile="] )
	except getopt.GetoptError:
		usage()
		sys.exit(2)
	for opt, arg in opts:
		if opt == '-h':
			usage()
			sys.exit()
		elif opt in ("-r", "--referencefile"):
			inputfile = arg
		elif opt in ("-s", "--snpfile"):
			inputfile = arg
	

	create_subset_ref(  reffile, snpfile,)

if __name__ == "__main__":
   main(sys.argv[1:])

