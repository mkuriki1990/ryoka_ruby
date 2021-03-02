#!/bin/sh
# ������Ϳ���� PDF �ե������ PNG �������Ѵ����륹����ץ�

for files in $@
do
    # ��ĥ�Ҥ�����ե�����̾�����
    filename=`basename ${files} | sed -e "s/^\(.*\)\.[^\.]*$/\1/"`
    convert -verbose -density 400 -trim $files -quality 100 -sharpen 0x1.0 ${filename}.png
done
