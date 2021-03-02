#!/bin/sh
# 引数に与えた PDF ファイルを PNG 画像に変換するスクリプト

for files in $@
do
    # 拡張子を除くファイル名を取得
    filename=`basename ${files} | sed -e "s/^\(.*\)\.[^\.]*$/\1/"`
    convert -verbose -density 400 -trim $files -quality 100 -sharpen 0x1.0 ${filename}.png
done
