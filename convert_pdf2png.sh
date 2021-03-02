#!/bin/sh
# 引数に与えた PDF ファイルを PNG 画像に変換するスクリプト
# ImageMagick の設定によっては PDF が読み込めないので
# /etc/ImageMagick-6/policy.xml において以下のように修正する

# 大体 77 行目ぐらい
# <policy domain="coder" rights="none" pattern="PDF" /> # 修正前
# <policy domain="coder" rights="read|write" pattern="PDF" /> # 修正後

for files in $@
do
    # 拡張子を除くファイル名を取得
    filename=`basename ${files} | sed -e "s/^\(.*\)\.[^\.]*$/\1/"`
    convert -verbose -density 400 $files -quality 100 -sharpen 0x1.0 ${filename}.png
done
