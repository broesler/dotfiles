#!/bin/bash
#===============================================================================
#     File: ~/.bashrc.d/aliases.bash
#  Created: 12/04/14
#   Author: Bernie Roesler
# 
#  Description: Contains aliases and simple functions for use with the bash
#       shell. This file is only loaded with ~/.bashrc for interactive shells.
# 
#===============================================================================

alias ep='vim ~/.bash_profile'               # edit profile (loaded with login)
alias erc='vim ~/.bashrc'                    # edit rc file (loaded with bash)
alias ea='vim ~/.bashrc.d/aliases.bash'      # edit aliases (loaded after rc)
alias rp='source ~/.bash_profile'            # reload profile

#-------------------------------------------------------------------------------
#       FOLDER AND APPLICATION SHORTCUTS
#-------------------------------------------------------------------------------
host=$(hostname -s) # i.e. 't1854', 'babylon', 'polaris'

case "$host" in
t1854)  # my MBP
    # Matlab with rlwrap (use vi commands in Matlab!)
    function matlabrl()
    {
        # $PATH includes: /Applications/MATLAB_R2015b.app/bin/
        rlwrap -a dummy -c -m dummy \
            -H $HOME/.matlab/R2025a/history.m \
            matlab -nosplash -nodesktop "$@"
    }
    ;;
esac

#-------------------------------------------------------------------------------
#       UTILITIES
#-------------------------------------------------------------------------------
# gfortran options
gfopts=' -cpp -Wall -pedantic -std=f95'
gfopts+=' -fbounds-check -ffree-line-length-0 -fbacktrace -fall-intrinsics'

alias clc='clear'
alias df='df -kTh'
alias diff='diff --color=auto'
alias du='du -kh'
alias grep='grep --color=auto'
alias h='history | command less +G'
alias j='jobs -l'
alias lt='tree -C'
alias mkdir='mkdir -p'
alias mygcc='gcc-10 -Wall -pedantic -std=c99'
alias mygfortran="gfortran $gfopts"
alias pandoc='/usr/local/bin/pandoc'
alias showpath='echo $PATH | tr -s ":" "\n"'
alias sicp='rlwrap -r -c -f "$HOME"/src/scheme/mit_scheme_bindings.txt scheme'
alias ta='type -a'

# Color list
[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
[ -e "$DIR_COLORS" ] || DIR_COLORS=""

# Set ls with colors
if ! command -v dircolors &> /dev/null; then
    eval "$(dircolors -b $DIR_COLORS)"  # set custom colors file
fi
alias lc='ls -Ghlp --color=auto'    # gnu-ls options

# Show hidden files only
alias lcd='lc -d .*'

# back up multiple directories
alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'

#===============================================================================
#===============================================================================
# vim: ft=sh syntax=sh
