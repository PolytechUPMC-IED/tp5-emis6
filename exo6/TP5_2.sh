#!/bin/sh

tar -zxvf $1
list=`ls`

html_start="<html><head><title> Trombinoscope Spé xx</title></head>
<body>"
html_end="</body></html>"

head_start="<h1 align=’center’>"
head_end="</h1>"

table_start="<table cols=2 align=’center’>"
table_end="</table>"


echo $list

cut -d"_" -f 1 <<< $list

for i in $list
do
	filename=`basename $i`
	echo "filename: $filename"
	extension="${filename##*.}"
	echo "extension: $extension"
	if [[ $extension == "jpg" ]];
		then 
		#echo "ext: $extension doing the makedir"
		group=`cut -d"_" -f 3 <<< $filename`
		groupnum=`cut -d"_" -f 4 <<< $filename`
		groupnum=`cut -d"." -f 1 <<< $groupnum`
		convert -resize 90x120 "$filename" "$filename"

		if mkdir "$group$groupnum";
			then
			echo "$group$groupnum" >> filieres.txt
		fi
		mv "$filename" "$group$groupnum"


	fi
done

specialities=`cat filieres.txt`
echo "spes: $specialities"

for i in $specialities
do
	cd "$i";
	students=`ls`;
	echo "$head_start Trombinoscope Spe $i $head_end" >> index.html;
	echo "$table_start" >> index.html;
	for j in $students
	do
		echo "<tr>
		<td><img src="$j" width=90 height=120/><br/>`cut -d"_" -f1 <<< $j` `cut -d"_" -f2 <<< $j`</td>">>index.html;
		$j = `expr $j+1`;
		echo"
		<td><img src="$j" width=90 height=120/><br/>`cut -d"_" -f1 <<< $j` `cut -d"_" -f2 <<< $j`</td>
		</tr>" >>index.html;
	done
	echo "$table_end" >> index.html;
	echo "$html_end" >> index.html;
	cd ../;
done



