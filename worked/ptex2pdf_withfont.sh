#!/bin/sh

for files in $*
do
    ptex2pdf -l -od "-f ../uptex-kozuka-pr6n-04.map -f ../otf-kozuka-pr6n.map" $files
done

