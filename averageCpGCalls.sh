
#!/bin/bash

if [ "$1" == "-h" ] ; then
  echo -e "Average CpG calls for files matching RegEx
  Usage: `basename $0` -i <dirIn> -f <files> -c <column> -p <pos>
  <dirIn>: input directory
  <files>: files to be analyzed
  <column>: column no. of CpG call in files
  <pos>: threshold [0,1] for calling CIMP +"
  exit 0
fi

## store input
while [ $# -gt 0 ]
do
  case "$1" in
    -i) dirIn="$2"; shift;;
    -f) files="$2"; shift;;
    -c) col="$2"; shift;;
    -p) pos="$2"; shift;;
  esac
  shift
done

## accumulate
cd $dirIn
for f in $files
do

  ## produce + for average above threshold; - otherwise
  awk -v N=$col -v P=$pos '{ sum += $N } END { AVG = sum / NR; if (NR > 0 && AVG >= P) print "+"; else print "-" }' $f

done
