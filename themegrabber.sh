#!/bin/bash
number=1
choice=""
themes[0]=""
for file in /home/hgdesign/www/themes/WordPress/* 
do
	echo "$number. ${file:36}"
	(( number++ ))
	themes[${number-1}]=${file:36}
done

echo -e "Which theme would you like?"
read choice
echo "You chose ${themes[$choice+1]}"
