#!/bin/bash 

# NOTICE - Yes, this runs a new shell each time you move between gam profiles
# so if you're trying to conserve memory/resouces on your machine be mindful of this

# 1. Update to something like this in your ~/.bashrc file
# GAM=$HOME/bin/gamadv-xtd3/gam
# GAMSECTION=$($GAM config verify | grep -oP '(?<=domain = )[^ ]*')
# if [ "$color_prompt" = yes ]; then
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]:\[\033[01;31m\][$GAMSECTION]\[\033[00m\]\$ '
# else
# PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\ $GAMSECTION $ '

# 2. Set this file as an alias based on where you saved the file
# alias gamselect='$HOME/scripts/gamselect.sh'

# 3. This is the code used in this gamselect.sh file
GAM=$HOME/bin/gamadv-xtd3/gam

if [ "$1" != "" ]; then
    $GAM select $1 save
    exec bash
else
    echo "Positional parameter 1 is empty"
fi
