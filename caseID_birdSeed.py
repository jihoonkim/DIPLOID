# Test run:
# python caseID_birdSeed.py -b /Users/maxabruzzi/Documents/Research/bioCADDIE/100PilotCases/testDir/ -o case_birdSeed -m pilotCaseMeta.csv

import os, sys, getopt, re, csv, fnmatch

def getfileCaseGenderDict(metafile):
    fileCaseGenderDict = {}
    with open(metafile) as csvfile:
        reader = csv.DictReader(csvfile, delimiter = ',')
        for row in reader:
            if row['file_id'] not in fileCaseGenderDict:
                fileCaseGenderDict[row['file_id']] = (row['case_id'], (1 if row['gender'] == 'male' else 2))
    return fileCaseGenderDict

def getDirlist(birdseedDir):
    dirlist = os.listdir(birdseedDir)
    return dirlist


def main(argv):
    birdseedfile = ''
    outputfile = ''
    try:
        opts, args = getopt.getopt(argv,"hb:o:m:",["birdseedparentdir=","outputdir=","metafile="])
    except getopt.GetoptError:
        print('makePedfile.py -b <birdseedparentdir> -o <outputfiledir> -m <metafile>')
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print('makePedfile.py -b <birdseedparentdir> -o <outputfiledir> -m <metafile>')
            sys.exit()
        elif opt in ("-b", "--birdseedparentdir"):
            birdseedDirectory = arg
        elif opt in ("-o", "--outputfiledir"):
            outputfileDirectory = arg
        elif opt in ("-m", "--metafile"):
            caseMetafile = arg   
    
    fileCaseGenderDict = getfileCaseGenderDict(caseMetafile)

    fileDirList = getDirlist(birdseedDirectory)
    
    if not os.path.exists(outputfileDirectory):
        os.makedirs(outputfileDirectory)
    
    caseID_birdseedfile = outputfileDirectory + '/' + 'caseID.birdseed.csv'
    
    with open(caseID_birdseedfile,'w') as outfile:
        
        for fileDir in fileDirList:
            caseID = fileCaseGenderDict[fileDir][0]
            fileDirpath = birdseedDirectory + '/' + fileDir
            birdseedfile = ''
            
            for file in os.listdir(fileDirpath):
                if fnmatch.fnmatch(file, '*.birdseed.data.txt'):
                    print("Found " + file + " is birdseed file, ready to convert.")
                    birdseedfile = fileDirpath + '/' + file
                    
                    print("Prefixing the case_id to all rows in " + birdseedfile + ", re-write it into "\
                        + caseID_birdseedfile)
                        
                    with open(birdseedfile,'r') as infile:
#                         use headercount to skip the number of line of headers
                        headercount = 0
                        while (headercount < 2):
                            header = infile.readline()
                            headercount += 1
                        for line in infile:
#                             use lstrip() to remove leading spaces in line
                            outfile.write(caseID + '\t' + line)
                
if __name__ == "__main__":
    main(sys.argv[1:])