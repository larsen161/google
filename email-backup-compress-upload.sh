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
gyb=/home/steve/gyb/gyb
gybbase=GYB-GMail-Backup-
gybdata=/home/steve/gyb/GYB-GMail-Backup-

# Set the GAM variables
# Change your user, gam path, shared drive ID
user=steve
gam=/home/steve/bin/gamadv-xtd3/gam
shared_drive=0ABxUabcdefgUk9PVA

# Backup, Compress, Upload files
email=steve@domain.com
$gyb --email $email
7z u $gybdata$email.7z $gybdata$email
$gam user $user add drivefile localfile $gybbase$email.7z teamdriveparentid $shared_drive teamdriveparentname $today

email=steve@another-domain.com
$gyb --email $email
7z u $gybdata$email.7z $gybdata$email
$gam user $user add drivefile localfile $gybbase$email.7z teamdriveparentid $shared_drive teamdriveparentname $today
