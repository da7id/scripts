#!/bin/bash


##########       Get User Input for naming       ###########
validator=""
while [ "$validator" != "y" ]; do
	echo -e "Customer's cPanel UserName:		"
	read user
	echo -e "Customer's Name (FirstnameLastname): 	"
	read clientname
	echo -e "Customer's domain:			"
	read domain
	echo -e "Customer's Client ID:			"
	read clientid
	echo -e "Does this look correct?\nUser:\t\t\t$user\nName:\t\t\t$clientname\nDomain:\t\t$domain\nClientID:\t$clientid"
	read validator
done

##########       Generate full CPMOVE backup     ###########
/scripts/pkgacct $user

#########        Move backups file to correct place ########
mv /home/cpmove-$user.tar.gz /home/hgdesign/backups/cpmove-$user.tar.gz

########         Set Ownership of new file       ###########
chown hgdesign /home/hgdesign/backups/cpmove-$user.tar.gz
chgrp hgdesign /home/hgdesign/backups/cpmove-$user.tar.gz

#######          Fix naming of backup file       ###########
mv /home/hgdesign/backups/cpmove-$user.tar.gz /home/hgdesign/backups/$clientid-$clientname-$domain.tar.gz

######           Ask to kill account?            ###########
echo -e "Would you like to terminate the account?(type YES for yes)?"
read validator
if [ "$validator" == "YES" ]; then
	/scripts/killacct $user
fi
