#!/bin/bash

ORG_FILE=org.txt
SRC_FILE=raw2.txt
SRC_LINE_FILE=raw2_line.txt
SRC_FILTE_FILE=raw2_filte.txt

rm -f $SRC_FILE $SRC_LINE_FILE $SRC_FILTE_FILE

dos2unix $ORG_FILE
sed 's/\\/\\\\/g' $ORG_FILE > $SRC_FILE
awk ' BEGIN { ORS="\n"; line="";} {  if($0=="") { row=0; print line; line=""; print "\n"; } else { if(row==1) {line=sprintf("%s %s", line, $0);} else { line=sprintf("%s@%s", line, $0); } row++; } }' $SRC_FILE > $SRC_LINE_FILE
echo "Total stack frame:"
cat $SRC_LINE_FILE | grep -v '^$' | wc -l
sed -i 's/^@*//g' $SRC_LINE_FILE
echo "Total memory size:"
awk -F' ' 'BEGIN { sum=0; } { if($0!="") { sum+=$1; } } END { print sum; }' $SRC_LINE_FILE
sed -r 's/^([0-9]*) (.*)/\1\t\2/g' $SRC_LINE_FILE | awk -F'\t' '{ if($0!="") { sum[$2]+=$1; count[$2]+=1;}} END { for (k in sum) { printf("%d\t%d@%s\n", sum[k], count[k], k); }}' | sed '/^$/d' | sort -r -n > $SRC_FILTE_FILE
echo "Unique stack frame:"
cat $SRC_FILTE_FILE | wc -l

echo
./mem_ana.sh | sed 's/^\t*//g' | awk 'BEGIN {start=0;} { if(start==1) start=2; if(start==0 && $0=="include:") start=1; if(start==2) { if($0!="") {print $0;} else {start=0;} } }' | sed -r 'N;s/\n/\t/g'