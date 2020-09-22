#!/bin/bash

# Purpose: Backup multiple email accounts, compress, upload to Drive

# Requirements
# GAMADV-XTD3 - https://github.com/taers232c/GAMADV-XTD3/wiki
# GYB - https://github.com/jay0lee/got-your-back/wiki
# 7z - sudo apt-get install p7zip-full

# Set some broad use case variables
today=`date +%Y-%m-%d`

# Set the GYB variables
# Set your gyb path and gybdata values. gybbase is default format used
GYB=/Users/$USER/bin/gyb/gyb
GYBbase=GYB-GMail-Backup-
GYBdata=/Users/$USER/GSuite-Backups/GYB-GMail-Backup-

# Set the GAM variables
# Change your gam path, shared drive ID, and GSuite admin user 
GAM=~/bin/gamadv-xtd3/gam
SHARED_DRIVE=1rcVk34XAQmMuWWyIe3dNTD2UCC-hKl6r
ADMIN=service-account@domain.com

# Check for $MAILBOX command line argument, otherwise prompt for mailbox
check_mailbox() {
	if [ -z $MAILBOX ]
	then
		get_mailbox
    else 
        return
    fi
}

# Check for $CSV_FILE command line argument, otherwise prompt for csv location
check_csv() {
	if [ -z $CSV_FILE ]
	then
		get_csv
    else 
        return
    fi
}

# Verify user account exists in Google Suite
email_verification() {
    if $GAM info user $MAILBOX >/dev/null 2>&1; 
    then
        return
    else
        echo -e "\033[0;31m$MAILBOX does not exist in your GSuite org.\033[0m"
    fi
    echo -e "\033[0;31mPlease enter a valid email address.\033[0m"
    exit 1
}

# Capture the address of the mailbox to be backed up
get_mailbox () {
echo -n "Enter email address of the account you wish to backup & press Enter: "
read -r MAILBOX
}

# Capture the location of the csv file
get_csv () {
echo -n "Enter full path of the csv file you wish to to backup & press Enter: "
read -r CSV_FILE
}

# Backup, Compress, Upload files
backup_mailbox () {
echo -e "\033[1;33m*** The email to be backed up is $MAILBOX ***\033[0m"
$GYB --email $MAILBOX --local-folder $GYBdata$MAILBOX --service-account
7z u $GYBdata$MAILBOX.7z $GYBdata$MAILBOX
$GAM user $ADMIN add drivefile drivefilename $MAILBOX mimetype gfolder teamdriveparentid $SHARED_DRIVE
$GAM user $ADMIN add drivefile localfile $GYBdata$MAILBOX.7z teamdriveparentname $MAILBOX
}


PS3='Select your email backup preference: '
options=('Single User' 'Bulk csv' 'Quit')
select opt in "${options[@]}"
do
  case $opt in
    'Single User')
      check_mailbox
      email_verification
      backup_mailbox
      break
      ;;

    'Bulk csv')
      check_csv
      OLDIFS=$IFS
      IFS=','
      [ ! -f $CSV_FILE ] && { echo -e "\033[0;31m$CSV_FILE file not found\033[0m"; exit 99; }
      while read MAILBOX
      do
      	check_mailbox
        email_verification
        backup_mailbox
      done < $CSV_FILE
      IFS=$OLDIFS
      break
      ;;

    'Quit')
      break
      ;;

    *) echo invalid option;;
  esac
done
