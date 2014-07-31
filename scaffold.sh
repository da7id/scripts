#!/bin/bash

<<<<<<< HEAD
##
 #VARIABLES
#

=======

##
 #VARIABLES
#
>>>>>>> 46e41dd67e7cd4795e8d73613e6a8039a50667bc
INITIALPATH=`pwd`


##
 # Make new cPanel Account
##
<<<<<<< HEAD

=======
>>>>>>> 46e41dd67e7cd4795e8d73613e6a8039a50667bc
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
<<<<<<< HEAD

=======
>>>>>>> 46e41dd67e7cd4795e8d73613e6a8039a50667bc
/scripts/wwwacct $domain $cpaneluser $password 1000 0 n n n 10 10 10 10 10 5000 y hgdesign hgdesign_default 10 10


##
 # Create new WordPress Install
##
<<<<<<< HEAD



=======
>>>>>>> 46e41dd67e7cd4795e8d73613e6a8039a50667bc
WPPATH=/home/$cpaneluser/www/
cd $WPPATH
MYSQLUSER="$cpaneluser"_wrdp1
MYSQLDBNAME="$cpaneluser"_wrdp1
<<<<<<< HEAD
MYSQLPASS=`cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w ${1:-32} | head -n 1`
=======
MYSQLPASS="hostgator123"
>>>>>>> 46e41dd67e7cd4795e8d73613e6a8039a50667bc
mysql -u root --execute="CREATE DATABASE ${MYSQLDBNAME};"
mysql -u root --execute="CREATE USER '${MYSQLUSER}'@'localhost' IDENTIFIED BY '${MYSQLPASS}';"
mysql -u root --execute="GRANT ALL PRIVILEGES ON ${MYSQLDBNAME} . * TO '${MYSQLUSER}'@'localhost';"
su $cpaneluser -c "wp core download --force"
su $cpaneluser -c "wp core config --dbname=$MYSQLDBNAME --dbuser=$MYSQLUSER --dbpass=$MYSQLPASS"
su $cpaneluser -c "wp core install --url=\"198.20.227.88/~$cpaneluser\" --title=\"New WordPress\" --admin_user=\"$cpaneluser\" --admin_password=\"hostgator123\" --admin_email=\"dbarron@hostgator.com\""
cd $INITIALPATH
