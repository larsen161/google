#!/bin/bash
# Set the path to the GAM you want to use
GAM=/home/larsen161/bin/gamadv-xtd3/gam
GAMFILEPATH=~/gam-data

# Capture the first name details
get_firstname () {
echo -n "Enter the first name & press Enter: "
read -r firstname
}

# Capture the lastname
get_lastname () {
echo -n "Enter the last name & press Enter: "
read -r lastname
}

# Capture the username details
get_username () {
echo -n "Enter the username & press Enter: "
read -r username
}

# Capture the job title
get_jobtitle () {
echo -n "Enter the job title & press Enter: "
read -r jobtitle
}

# Capture the manager
get_mananger () {
echo -n "Enter the manager email & press Enter: "
read -r manager
}

#Capture the OU they should be in
get_ou () {
echo -n "Enter OU & press Enter: "
read -r ou
}

# Create the user
create_user () {
$GAM create user $username firstname $firstname lastname $lastame ou $ou relation manager $manager
}

# Things all users should be a member of
add_user_all () {
$GAM update group everyone add member $username delivery allmail
#Everyone My Drive Folder
$GAM user $username update drivefile id:1xtsXj67uxLEh_L34GTXAxvkCg0vUMEqG addparent root
}

# Groups Marketing users should be a member of
add_user_marketing () {
$GAM update group marketing add member $username delivery allmail
#Marketing My Drive Folder
$GAM user $username update drivefile id:1nB6XXdFKiWDOn7FUiG2jz-zvvAITfJos addparent root
}

# Groups Engineering users should be a member of
add_user_engineering () {
$GAM update group engineering add member $username delivery allmail
#Engineering My Drive Folder
$GAM user $username update drivefile id:1CaW-1-fXR_Lq-oHfctRlM8tNkqkmDvHI addparent root
}

PS3='Select the users department: '
options=('Marketing' 'Engineering' 'Quit')
select opt in "${options[@]}"
do
  case $opt in
    'Marketing')
      get_firstname
      get_lastname
      get_username
      get_jobtitle
      get_mananger
      get_ou
      create_user
      
      add_user_all
      add_user_marketing

      break
      ;;
    'Engineering')
      get_firstname
      get_lastname
      get_username
      get_jobtitle
      get_mananger
      get_ou
      create_user
      
      add_user_all
      add_user_engineering

      break
      ;;
    'Quit')
      break
      ;;
    *) echo invalid option;;
  esac
done
