#!/bin/bash
# Set the path to the GAM you want to use
GAM=$HOME/bin/gamadv-xtd3/gam

# Make a copy of this form
# https://docs.google.com/forms/d/1dng2Yud5v0-EAVnrJtEG_VK_1KjGIonLgk5DPtGOCKw/copy

# Then get the sheet ID for the responses to update the ID value below
# There are 3 additional columns that need to be added to the sheet
# These are admin defined values which are used in the commands below
# username = this is the username that makes up the users email. You define it as user or user@domain.com depending on your gam and domain setup
# ou = what ou should the user be created in
# onboarding = an email to notify your onboarding team along with the new hire after notify in the first command

# Configure your organisation default and file info
ADMIN=admin@domain.com
ONBOARDING=onboarding@domain.com
ID=1oIDdFydVgHoDC9saEuf6eH7YSSD8HLDEWe7vIrwcJ3I
TABNAME=pendingHires
OU=Secured/2SVDelayed

$GAM csv gsheet $ADMIN $ID $TABNAME gam create user ~"username" firstname ~"First Name" lastname ~"Last Name" ou ~"ou" relation manager ~"Manager Email" groups member delivery allmail team notify "~~$personalemail~~,~~onboarding~~"
$GAM csv gsheet $ADMIN $ID $TABNAME gam update user ~"username" phone type mobile value ~"Mobile Phone" primary organization title ~"Job Title" department ~"Primary Team" location ~"Primary Location" primary
