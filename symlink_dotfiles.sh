#!/bin/bash
#==============================================================================
#    File: symlink_dotfiles.sh
# Created: 02/26/2015
#  Author: Bernie Roesler
#
# Description: Creates symlinks to dotfiles from $HOME directory after cloning
#   into ~/.dotfiles/
#==============================================================================

# Array of files in directory
files=(*)

# Symlink each file to correct file (adding . to filename)
for f in "${files[@]}";
do
  # exclude README and this script 
  if [[ $f != README.* ]] && [[ $f != $(basename $0) ]]  
  then
    # symlink files, do not follow symbolic links that already exist 
    # (i.e. directories), check if user wants to overwrite existing files
    command ln -nsvfh $HOME/.dotfiles/$f $HOME/.$f
  fi
done

exit 0
