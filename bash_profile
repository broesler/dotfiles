#!/bin/bash
# Set vim syntax: vim:ft=sh syntax=sh
#===============================================================================
#     File: ~/.bash_profile
#  Created: 10/29/13
#   Author: Bernie Roesler
#
#  Description: Loads for all login shells. Sets path variable and others
#===============================================================================

host=$(hostname -s) # i.e. 't1854', 'babylon', 'polaris'

# Only on my Macbook, assumed OK on other machines
case "$host" in
t1854)
    # Set architecture flags for compilers
    export ARCHFLAGS="-arch x86_64"

    # Default PATH
    export DEFAULT_PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    export PATH="$DEFAULT_PATH:/opt/X11/bin"

    # Add coreutils from homebrew $(brew --prefix coreutils)
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

    # # Ruby setup:
    # # Load RVM into a shell session *as a function*
    # [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
    # # export PATH="$PATH:$HOME/.rbenv/shims"
    # eval "$(rbenv init -)"
    # export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
    # export PATH="$PATH:/usr/local/heroku/bin"

    # Add LaTeX and git binaries
    export PATH="$PATH:/Library/TeX/texbin"          # LaTeX
    export PATH="$PATH:/usr/local/git/bin"           # git

    # Add MATLAB binaries to path (for mlint, etc.)
    export MATLAB_PATH="/Applications/MATLAB_R2018a.app/bin"
    export PATH="$PATH:$MATLAB_PATH"

    export TF_CPP_MIN_LOG_LEVEL=2   # ignore some tensorflow warnings

    # Include my own python utility scripts
    export PYTHONPATH="$PYTHONPATH:$HOME/src/python/util"

    # added by Anaconda3 5.2.0 installer
    export PATH="/Users/bernardroesler/anaconda3/bin:$PATH"

    # FIXME HACK to make sqlalchemy work with mysql homebrew update...
    export DYLD_LIBRARY_PATH="/usr/local/opt/mysql/lib/:$DYLD_LIBRARY_PATH"

    # brew doctor needs this line as of El Cap update 11/17/15
    export LC_ALL=en_US.UTF-8  

    # Shortcuts to directories
    export RES="$HOME/Documents/School/Research/"     # path to research folder
    # export STY=$HOME/Library/texmf/tex/latex/       # path to latex style files
    export MAT="$HOME/Documents/MATLAB/"              # path to Matlab files
    export ORPC="$HOME/Kite_Drive/2016_ORPC_drone_turbine_(Roesler)/"

    # Add homebrewed utilities to the manpath $(brew --prefix ...)
    export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"
    export MANPATH="/usr/local/opt/findutils/share/man:$MANPATH"
    export MANPATH="/usr/local/opt/ed/share/man:$MANPATH"
    export MANPATH="/usr/local/opt/gnu-sed/share/man:$MANPATH"
    export MANPATH="/usr/local/opt/grep/share/man:$MANPATH"
    export MANPATH="/usr/local/opt/gnu-tar/share/man:$MANPATH"
    export MANPATH="/usr/local/opt/gnu-which/share/man:$MANPATH"

    # mit-scheme set-up
    export MIT_SCHEME_EXE='/usr/local/bin/mit-scheme'
    # export MIT_SCHEME_EXE='/Applications/MIT-Scheme.app/Contents/Resources/mit-scheme'
    export MITSCHEME_LIBRARY_PATH='/usr/local/lib/mit-scheme-c/'

    # ensure tmux uses colors (not sure if I need this on babylon)
    export TERM='screen-256color'
    ;;

BROESLER-T480)  # Ubuntu on Windows PC (Lenovo T480 for work)
    export WINHOME='/mnt/c/Users/broesler/'  # path to home directory (C:)
    export MAT="$WINHOME/Documents/MATLAB/"  # path to Matlab files

    # Rust path
    export PATH="$PATH:$HOME/.cargo/bin"

    # add MATLAB files (mlint.exe, etc.)
    export MATLAB_PATH="/mnt/c/Program Files/MATLAB/R2015b/bin/win64"
    export PATH="$PATH:$MATLAB_PATH"

    # add Star-CCM+ path
    export STAR_PATH="/mnt/c/Program Files/CD-adapco/13.06.012/STAR-CCM+3.06.012/star/bin/"
    export PATH="$PATH:$STAR_PATH"

    # added by Anaconda3 4.5.4 installer
    # export PATH="/home/broesler/anaconda3/bin:$PATH"

    export WINDOWS_PATH='C:\Users\broesler\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\rootfs\home\broesler\'

    # Allow X11 to work
    export DISPLAY=localhost:0.0
    ;;
esac

# Add my local files
export PATH="$PATH:$HOME/bin"
export SAVE_PATH=$PATH  # useful to check if anything has modified PATH

# default less options (-A fails on older versions)
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
