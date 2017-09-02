#!/bin/sh

for filename in "$@"
do
	nkf -Lu $filename | \
	sed \
		-e "s/$/\\\\\\\\/g" \
		-e "1,+4! s/[^ぁ-ん|^ァ-ヴー|、|。|\r|\.|(|)|^0-9|^a-zA-Z| |　]/\\\\ruby{&}{}/g" \
		-e "s/{}\\\\ruby{//g" \
		-e "s/{}/#/g" \
		-e "s/\(.\)}/\1/g" \
		-e "s/#/}{}/g" \
		-e "s/[0-9]\./\\\\vspace{\\\\linespace}\n\\\\item/g" \
		-e 's/$/\\/g' \
		-e "s/\\\\\\\\\\\\/\\\\\\\\/g" \
		-e "s/^\\\\\\\\$//g" \
		-e "s/\\\\item\\\\\\\\/\\\\item/g" \
		> ${filename}.ruby
		# | tee ${filename}.ruby

	while read line
	do
		echo %${line}
		if [ -z "${line}" ]; then
			break;
		fi
	done < ${filename}.ruby
done
