#!/bin/sh
# worked �ǥ��쥯�ȥ�ʲ��ˤ��� TeX ����������ꤷ��
# �Ҥ餬�� txt �ե������ ruby �������֤������� HTML �ե������
# �������뤿��Υ�����ץ�

filename=$@

cd ./html/
./mkhtml.rb ../$filename

cd ../kana/
./mkkana.rb ../$filename

