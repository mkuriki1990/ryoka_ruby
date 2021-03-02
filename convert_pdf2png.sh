#!/bin/sh
# ������Ϳ���� PDF �ե������ PNG �������Ѵ����륹����ץ�
# ImageMagick ������ˤ�äƤ� PDF ���ɤ߹���ʤ��Τ�
# /etc/ImageMagick-6/policy.xml �ˤ����ưʲ��Τ褦�˽�������

# ���� 77 ���ܤ��餤
# <policy domain="coder" rights="none" pattern="PDF" /> # ������
# <policy domain="coder" rights="read|write" pattern="PDF" /> # ������

for files in $@
do
    # ��ĥ�Ҥ�����ե�����̾�����
    filename=`basename ${files} | sed -e "s/^\(.*\)\.[^\.]*$/\1/"`
    convert -verbose -density 400 $files -quality 100 -sharpen 0x1.0 ${filename}.png
done
