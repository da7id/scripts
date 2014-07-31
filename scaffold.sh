#!/bin/bash

##########     Function Creation   ##########
function error_exit
{
	echo "$1" 1>&2
	exit 1
}

function print_files
{
	number=1
	for file in /home/hgdesign/www/themes/WordPress/zipfiles/*
	do
		echo "$number. ${file:45}"
		(( number++ ))
		themes[${number-1}]=${file:45}
	done
}
##########     Get User Input      ##########
validator=""
while [ "$validator" != "y" ]; do
	echo -e "User?"
	read cpaneluser
	echo -e "Domain?"
	read domain
	echo -e "Pass?"
	read password
	echo -e "Look right?(y/n)\n----------------\nUser: $cpaneluser \nDomain: $domain \nPass: $password"
	read validator
done

##########     Create Script Variables      ##########
WPPATH=/home/$cpaneluser/www/

MYSQLUSER="$cpaneluser"_wrdp1
MYSQLDBNAME="$cpaneluser"_wrdp1
MYSQLPASS=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1`

##########       Create cPanel Account      ##########
/scripts/wwwacct $domain $cpaneluser $password 1000 0 n n n 10 10 10 10 10 5000 y hgdesign hgdesign_default 10 10 || error_exit "Could not create cPanel User account, script terminating"

##########       Create DB For Use by WP    ##########
mysql -u root --execute="CREATE DATABASE ${MYSQLDBNAME};" || error_exit "Could not create MySQL Database ${MYSQLDBNAME}, script terminating"
mysql -u root --execute="CREATE USER '${MYSQLUSER}'@'localhost' IDENTIFIED BY '${MYSQLPASS}';" || error_exit "Could not create MySQL User ${MYSQLUSER}, script terminating"
mysql -u root --execute="GRANT ALL PRIVILEGES ON ${MYSQLDBNAME} . * TO '${MYSQLUSER}'@'localhost';" || error_exit "Could not assign ${MYSQLUSER} to ${MYSQLDBNAME} successfully, script terminating"

##########      Create WordPress Install    ###########
cd $WPPATH || error_exit "Could not move to correct WP directory, $WPPATH, script terminating"
su $cpaneluser -c "wp core download --force" || error_exit "Could not download WordPress Core, script terminating"
su $cpaneluser -c "wp core config --dbname=$MYSQLDBNAME --dbuser=$MYSQLUSER --dbpass=$MYSQLPASS" || error_exit "Could not configure the WordPress Install on the correct Database ${MYSQLDBNAME}, script terminating"
su $cpaneluser -c "wp core install --url=\"198.20.227.88/~$cpaneluser\" --title=\"New WordPress\" --admin_user=\"$cpaneluser\" --admin_password=\"hostgator123\" --admin_email=\"dbarron@hostgator.com\"" || error_exit "Could not install correct variables to WordPress DB / Installation, script terminating"

##########       Get User Theme Choice       ##########
number=1
choice=""
themes[0]=""
validator="n"
while [ "$validator" != "y" ]; do
	print_files
	echo -e "Which theme would you like?"
	read choice
	theme=${themes[$choice+1]}
	echo "You chose #$choice. $theme. Is that correct?"
	read validator
done 
echo "You chose $theme, installing and activating."
cd /home/$cpaneluser/www
cp /home/hgdesign/www/themes/WordPress/zipfiles/$theme ./$theme
perms $cpaneluser
su $cpaneluser -c "wp theme install $theme --activate"
