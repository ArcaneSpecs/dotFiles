#!/bin/bash

SUM="91142c9d3a13a40538ef86355485549e  ../"

VALID=true

func()
{
    echo "Checking: $1"
    SUM=$(md5sum "$1")
    SUM=$(echo $SUM | awk '{print $1}')
    grep -i "$SUM" MD5/fitgirl-bins.md5
    if [ $? -ne 0 ]; then
        VALID=false
    fi

    echo "$1 is: $VALID"
}

while read -r line
do
    second_word=$(echo $line | awk '{print $2}')
    func "$second_word"
done < MD5/fitgirl-bins.md5

echo "SM5 validity was: $VALID"

if [ $VALID -eq 0 ]; then
    exit 0
else
    exit 1
fi

# if (NR > 1) print func($2) 
# awk '{
#         print grep -r -i $2
# }' MD5/fitgirl-bins.md5

# echo $(awk "$SUM")
# find . iname "*.bin" -exec md5sum {} | grep \;

