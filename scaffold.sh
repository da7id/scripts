#!/bin/bash

##########     Get User Input      ##########
while [ $INPUTVALIDATION -eq 0 ]; do
	echo -e "User?"
	read cpaneluser
	echo -e "Domain?"
	read domain
	echo -e "Pass?"
	read password
	echo -e "Look right?(type 1 for yes)\n----------------\nUser: $cpaneluser \nDomain: $domain \nPass: $password"
	read validator
	if [[ $validator == "y" ]]; then
		INPUTVALIDATION=1
	fi
done

##########     Create Script Variables      ##########
INPUTVALIDATION=0

INITIALPATH=`pwd`
WPPATH=/home/$cpaneluser/www/

MYSQLUSER="$cpaneluser"_wrdp1
MYSQLDBNAME="$cpaneluser"_wrdp1
MYSQLPASS=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1`

##########       Create cPanel Account      ##########
/scripts/wwwacct $domain $cpaneluser $password 1000 0 n n n 10 10 10 10 10 5000 y hgdesign hgdesign_default 10 10

##########       Create DB For Use by WP    ##########
mysql -u root --execute="CREATE DATABASE ${MYSQLDBNAME};"
mysql -u root --execute="CREATE USER '${MYSQLUSER}'@'localhost' IDENTIFIED BY '${MYSQLPASS}';"
mysql -u root --execute="GRANT ALL PRIVILEGES ON ${MYSQLDBNAME} . * TO '${MYSQLUSER}'@'localhost';"

##########      Create WordPress Install    ###########
cd $WPPATH
su $cpaneluser -c "wp core download --force"
su $cpaneluser -c "wp core config --dbname=$MYSQLDBNAME --dbuser=$MYSQLUSER --dbpass=$MYSQLPASS"
su $cpaneluser -c "wp core install --url=\"198.20.227.88/~$cpaneluser\" --title=\"New WordPress\" --admin_user=\"$cpaneluser\" --admin_password=\"hostgator123\" --admin_email=\"dbarron@hostgator.com\""
cd $INITIALPATH
