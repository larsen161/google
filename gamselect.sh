#!/bin/bash 

# NOTICE - This version will not start a new shell each time you move between gam profiles.
# There is a little bit more code in the gamselect.sh to set red and green PS1, 
# and the alias is altered to include the source command to activate the new PS1.

# As I have 0 byte json files in the .gam folder, my DEFAULT section is always safe, 
# and therefore green; no gam command can be run there. I recommend you do the same.
# Notice that I in the .bashrc auto-sets default section on start. Yeah, that's good.
# Therefore my default PS1 colour is 32, green, and not 31, red.

# 1. Update to something like this in your ~/.bashrc file
# GAM=$HOME/bin/gamadv-xtd3/gam
# $GAM select default save
# GAMSECTION=$($GAM config verify | grep -oP '(?<=domain = )[^ ]*')
# if [ "$color_prompt" = yes ]; then
# PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]:\[\033[01;32m\][$GAMSECTION]\[\033[00m\]\$ '
# else
# PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\ $GAMSECTION $ '

# 2. Set this file as an alias based on where you saved the file; I keep mine in ~/bin. The source bit is important.
# alias gamselect='source $HOME/bin/gamselect.sh'

# 3. This is the code used in this gamselect.sh file

# Set the path to the GAM you want to use
GAM=$HOME/gamadv-xtd3/gam

# If you change to default section, say so, and turn PS1 green (requires 0 byte json files, else it is NOT safe!).
if [ "$1" = "default" ]; then
$GAM select $1 save
GAMSECTION=$($GAM config verify | grep -oP '(?<=Section: )[^ ]*')
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]:\[\033[01;32m\]$GAMSECTION\[\033[00m\]\$ '

# Grab your supplied section word and apply it, and set PS1 to red.
# If you typo a section, you will get a gam error message and PS1 will still be turned red, to indicate it's not safe.
elif [ "$1" != "" ]; then
$GAM select $1 save
GAMSECTION=$($GAM config verify | grep -oP '(?<=Section: )[^ ]*')
PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]:\[\033[01;31m\]$GAMSECTION\[\033[00m\]\$ '

# If you forgot to supply a section, tell you, so you can run the command again.
else
echo "You have to choose a section"
fi
