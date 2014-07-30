#!/bin/bash

##
 #VARIABLES
#

INITIALPATH=`pwd`


##
 # Make new cPanel Account
##

INPUTVALIDATION=0
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

/scripts/wwwacct $domain $cpaneluser $password 1000 0 n n n 10 10 10 10 10 5000 y hgdesign hgdesign_default 10 10


##
 # Create new WordPress Install
##



WPPATH=/home/$cpaneluser/www/
cd $WPPATH
MYSQLUSER="$cpaneluser"_wrdp1
MYSQLDBNAME="$cpaneluser"_wrdp1
MYSQLPASS="hostgator123"
mysql -u root --execute="CREATE DATABASE ${MYSQLDBNAME};"
mysql -u root --execute="CREATE USER '${MYSQLUSER}'@'localhost' IDENTIFIED BY '${MYSQLPASS}';"
mysql -u root --execute="GRANT ALL PRIVILEGES ON ${MYSQLDBNAME} . * TO '${MYSQLUSER}'@'localhost';"
su $cpaneluser -c "wp core download --force"
su $cpaneluser -c "wp core config --dbname=$MYSQLDBNAME --dbuser=$MYSQLUSER --dbpass=$MYSQLPASS"
su $cpaneluser -c "wp core install --url=\"198.20.227.88/~$cpaneluser\" --title=\"New WordPress\" --admin_user=\"$cpaneluser\" --admin_password=\"hostgator123\" --admin_email=\"dbarron@hostgator.com\""
cd $INITIALPATH
