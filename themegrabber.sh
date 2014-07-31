#!/bin/bash
number=1
choice=""
themes[0]=""
for file in /home/hgdesign/www/themes/WordPress/zipfiles/* 
do
	echo "$number. ${file:45}"
	(( number++ ))
	themes[${number-1}]=${file:45}
done

echo -e "Which theme would you like?"
read choice
theme=${themes[$choice+1]}
echo "You chose $theme, installing and activating."
cd /home/ccyc/www
cp /home/hgdesign/www/themes/WordPress/zipfiles/$theme ./$theme
perms ccyc
su ccyc -c "wp theme install $theme --activate"
