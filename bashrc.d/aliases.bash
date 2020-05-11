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
        # $PATH includes: /Applications/MATLAB_R2018b.app/bin/
        rlwrap -a dummy -c -m dummy \
            -H $HOME/.matlab/R2018a/history.m \
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

alias df='df -kTh'
alias du='du -kh'
alias h='history | command less +G'
alias j='jobs -l'
alias lt='tree -C'
alias mkdir='mkdir -p'
alias mygcc='gcc-8 -Wall -pedantic -std=c99'
alias mygfortran="gfortran $gfopts"
alias showpath='echo $PATH | tr -s ":" "\n"'
alias sicp='rlwrap -r -c -f "$HOME"/src/scheme/mit_scheme_bindings.txt scheme'
alias ta='type -a'

# Color list
if [ -x /usr/bin/dircolors ]; then
    # set custom colors file
    [ -r ~/.dircolors ] && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias lc='ls -Ghlp --color=auto'    # gnu-ls options
    alias grep='grep --color=auto'
fi

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
