#!/bin/bash
# Set vim syntax: vim:ft=sh syntax=sh
#==============================================================================
#    File: ~/.bash_profile
# Created: 10/29/13
#  Author: Bernie Roesler
#
# Last Modified: 05/20/2016, 17:37
#
# Description: Loads for all login shells. Sets path variable and others
#==============================================================================

host=$(hostname -s) # i.e. 't1854', 'babylon', 'polaris'

# Only on my Macbook, assumed OK on other machines
case "$host" in
t1854)
    # Set architecture flags for compilers
    export ARCHFLAGS="-arch x86_64"

    # Default PATH
    export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"

    # Add coreutils from homebrew $(brew --prefix coreutils)
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

    # # Ruby setup:
    # # Load RVM into a shell session *as a function*
    # [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
    # # export PATH="$PATH:$HOME/.rbenv/shims"
    # eval "$(rbenv init -)"
    # export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
    # export PATH="$PATH:/usr/local/heroku/bin"

    # Add LaTeX binaries
    export PATH="$PATH:/Library/TeX/texbin"          # LaTeX
    export PATH="$PATH:/usr/local/git/bin"           # git

    # Add MATLAB binaries to path
    export PATH="$PATH:/Applications/MATLAB_R2016b.app/bin"

    export LC_ALL=en_US.UTF-8                   # brew doctor needs this line as of El Cap update 11/17/15 
    export RES=~/Documents/School/Research/     # path to research folder
    # export STY=~/Library/texmf/tex/latex/       # path to latex style files
    export MAT=~/Documents/MATLAB/              # path to Matlab files

    # Add homebrewed utilities to the manpath $(brew --prefix ...)
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    export MANPATH="/usr/local/opt/findutils/share/man:$MANPATH"
    export MANPATH="/usr/local/opt/ed/share/man:$MANPATH"
    export MANPATH="/usr/local/opt/gnu-sed/share/man:$MANPATH"
    export MANPATH="/usr/local/opt/grep/share/man:$MANPATH"
    export MANPATH="/usr/local/opt/gnu-tar/share/man:$MANPATH"
    export MANPATH="/usr/local/opt/gnu-which/share/man:$MANPATH"

    # mit scheme set-up
    export MIT_SCHEME_EXE='/usr/local/bin/mit-scheme'
    # export MIT_SCHEME_EXE='/Applications/MIT-Scheme.app/Contents/Resources/mit-scheme'
    export MITSCHEME_LIBRARY_PATH='/usr/local/lib/mit-scheme-c/'

    # ensure tmux uses colors (not sure if I need this on babylon/polaris?)
    export TERM='screen-256color'               
    ;;

# RSTOR data server @ Dartmouth
polaris)
    # Print "System Information" at login
    if [ -x /usr/local/bin/motd.make.sh ]; then
        /usr/local/bin/motd.make.sh
    fi
    ;;
esac

# Add my local files
export PATH="$PATH:$HOME/bin"

# default less options
export LESS=-AXFirsx8g

# less highlighting for man pages:
# NOTE: do not actually use "tput bold" because iTerm uses "bright" colors,
# which in Solarized scheme are just grayscale other than red
export LESS_TERMCAP_mb=$(tput setaf 2)            # start blink
export LESS_TERMCAP_md=$(tput setaf 3)            # start bold
export LESS_TERMCAP_me=$(tput sgr0)               # end bold
export LESS_TERMCAP_us=$(tput smul; tput setaf 4) # start underline
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)    # end underline
export LESS_TERMCAP_so=$(tput setaf 0; tput setab 3) # start highlight
export LESS_TERMCAP_se=$(tput sgr0) # end highlight

# Save OLDPWD between sessions
if [ -r "$HOME/.oldpwd" ]; then
    read -r OLDPWD < "$HOME/.oldpwd"
    export OLDPWD

    # add to stack without changing into it, so 'cd -' works
    pushd -n "$OLDPWD" > /dev/null
fi

#------------------------------------------------------------------------------
#       Load .bashrc file for interactive shells
#------------------------------------------------------------------------------
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
#==============================================================================
#==============================================================================
