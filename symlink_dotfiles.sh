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

# TODO use getopt to parse flags:
#   -f      force create all symlinks
#   -i      interactively create symlinks
#   none    only create symlinks for those that don't exist yet

# Symlink each file to correct file (adding . to filename)
for f in "${files[@]}";
do
    # exclude README and this script 
    if [[ $f != README.* ]] && [[ $f != $(basename $0) ]]  
    then
        if [ "$1" == "-f" ]; then
            # symlink files, do not follow symbolic links that already exist 
            # (i.e. directories)
            command ln -nsvf $HOME/.dotfiles/$f $HOME/.$f
        else
            # Check before overwriting
            command ln -nsvi $HOME/.dotfiles/$f $HOME/.$f
        fi
    fi
done

exit 0
#==============================================================================
#==============================================================================
