#!/bin/bash

echo $1
cat $1  | grep " [24]0. " | awk '{ print $3 " " $7 }' | rev | cut -c 3- | rev | sed 's/$/0x/' | sort | uniq -c > tmp.dat

while IFS='' read -r line || [[ -n "$line" ]]; do
        t=`echo $line | awk '{ print $2; }'`
        if [ "$t" = "$prevSrc" ]; then
                #echo $prev
                #echo $line 
                a=`echo $prev | awk '{ print $1 }'`
                b=`echo $line | awk '{ print $1 }'`
                if [ "$a" -gt 20 ] && [ "$b" -gt 20 ]; then
                        if [ "$a" -lt "$b" ]; then
                                echo $prev >> result.dat
                                echo $line >> result.dat
                        fi
                fi
        fi
        prev=$line
        prevSrc=$t
done < tmp.dat

