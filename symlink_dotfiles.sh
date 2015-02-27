#!/bin/bash
#==============================================================================
#    File: symlink_dotfiles.sh
# Created: 02/26/2015
#  Author: Bernie Roesler
#
# Description: Creates symlinks to dotfiles from $HOME directory after cloning
#   into ~/.dotfiles/
#==============================================================================

# Check if currently in ~/.dotfiles directory (and it exists)
if [ "$PWD" != "$HOME/.dotfiles" ] && [ -d "$HOME/.dotfiles" ]
then
  cd $HOME/.dotfiles
else
  printf "~/.dotfiles does not exist!\n" 1>&2
  exit 1
fi

# Array of files in directory
files=(*)

# Symlink each file to correct file (adding . to filename)
for f in "${files[@]}";
do
  if [[ $f != README.* ]]       # if file is NOT the README
  then
    ln -s $HOME/.dotfiles/$f $HOME/.$f
  fi
done

exit 0
