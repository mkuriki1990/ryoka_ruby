#!/usr/bin/ruby

# ファイル読み込み
templete = File.open('templete_B6.tex', 'r')

source = File.open('m40.txt.ruby', 'r')

buffer = templete.read();
src = source.read();

buffer.gsub!("LILYCS", src)
p buffer

fff = File.open('test.tex', 'w')

fff.write(buffer)
fff.close
