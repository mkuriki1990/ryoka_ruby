#!/bin/sh
# ������ī�ե���Ȥ��Ȥ߹���� PDF �ե��������Ϥ��뤿��Υ�����ץ�
# �ե���ȥޥåפ���ꤹ��ɬ�פ�����. 
# �������Ѵ������� .tex �ե������Ϳ����. 

for files in $*
do
    filename=${files%.*}
    # ptex2pdf -l -od "-f ../fontmap/uptex-kozuka-pr6n-04.map -f ../fontmap/otf-kozuka-pr6n.map" $files
    platex ${filename}.tex && dvipdfmx ${filename}.dvi
done

