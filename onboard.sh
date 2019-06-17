#!/bin/bash
# Set the path to the GAM you want to use
GAM=/home/s_larsen/bin/gamadv-xtd/gam
GAMFILEPATH=~/gam-data

# Capture the first name details
get_firstname () {
echo -n "Enter username of user to create & press Enter: "
read -r firstName

# Capture the lastname
get_lastname () {
echo -n "Enter username of user to create & press Enter: "
read -r lastname

# Capture the username details
get_username () {
echo -n "Enter username of user to create & press Enter: "
read -r username
}

# Create the user
create_user () {
$GAM create user $username firstname $firstname lastname $lastame org $org
}
