#!/bin/sh

for files in $*
do
    ptex2pdf -l -od "-f ../fontmap/uptex-kozuka-pr6n-04.map -f ../fontmap/otf-kozuka-pr6n.map" $files
done

