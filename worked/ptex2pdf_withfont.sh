#!/bin/sh
# 小塚明朝フォントを組み込んだ PDF ファイルを出力するためのスクリプト
# フォントマップを指定する必要がある. 
# 引数に変換したい .tex ファイルを与える. 

for files in $*
do
    filename=${files%.*}
    # ptex2pdf -l -od "-f ../fontmap/uptex-kozuka-pr6n-04.map -f ../fontmap/otf-kozuka-pr6n.map" $files
    platex ${filename}.tex && dvipdfmx ${filename}.dvi
done

