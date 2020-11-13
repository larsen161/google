#!/bin/bash
# Set the path to the GAM you want to use
GAM=$HOME/bin/gamadv-xtd3/gam

# Make a copy of this form and then get the sheet ID for the responses to update the ID value below
# https://docs.google.com/forms/d/1dng2Yud5v0-EAVnrJtEG_VK_1KjGIonLgk5DPtGOCKw/copy

# Configure your organisation default and file info
ADMIN=admin@domain.com
ONBOARDING=onboarding@domain.com
ID=1oIDdFydVgHoDC9saEuf6eH7YSSD8HLDEWe7vIrwcJ3I
TABNAME=pendingHires
OU=Secured/2SVDelayed

$GAM csv gsheet $ADMIN $ID $TABNAME gam create user ~"username" firstname ~"First Name" lastname ~"Last Name" ou ~"ou" relation manager ~"Manager Email" groups member delivery allmail team notify "~~$personalemail~~,~~onboarding~~"
$GAM csv gsheet $ADMIN $ID $TABNAME gam update user ~"username" phone type mobile value ~"Mobile Phone" primary organization title ~"Job Title" department ~"Primary Team" location ~"Primary Location" primary
