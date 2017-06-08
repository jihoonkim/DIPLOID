#!/bin/bash

# One import thing to make this to work is to make sure the file name is the same as in the corresponding table, the # extension of the file will be ignored in here. The order of the columns in the file has to be the same with that of the fields in the database table.
# To prevent from having typing in password each time, include password in the command line as:
# -u*root* -p*password* and update your user name and password in here accordingly

# Uncomment the corresponding one to allocate the table

#mysqlimport --fields-terminated-by=',' --verbose --local -u root -p --ignore-lines=1 affySNP6 metaInfo.csv
#mysqlimport --fields-terminated-by='\t' --verbose --local -u root -p --ignore-lines=0 affySNP6 hg18Map.csv
#mysqlimport --fields-terminated-by='\t' --verbose --local -u root -p --ignore-lines=1 affySNP6 affyProbe.csv
#mysqlimport --fields-terminated-by='\t' --verbose --local -u root -p --ignore-lines=1 affySNP6 rsidProbeMap.csv
mysqlimport --fields-terminated-by='\t' --verbose --local -u root -p --ignore-lines=1 affySNP6 birdSeed.csv

