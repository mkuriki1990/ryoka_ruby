#!/bin/sh
# worked ディレクトリ以下にある TeX ソースを指定して
# ひらがな txt ファイルと ruby タグに置き換えた HTML ファイルを
# 作成するためのスクリプト

filename=$@

cd ./html/
./mkhtml.rb ../$filename

cd ../kana/
./mkkana.rb ../$filename

