#!/bin/bash
for i in *.ped
do
  PREFIX=`basename $i .ped`
  echo $i
  cp ../plink.map $i.map 
done