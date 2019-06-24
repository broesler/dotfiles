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

    # Add coreutils from homebrew, i.e. $(brew --prefix coreutils)
    gnu_names=('coreutils' 'ed' 'findutils' 'gnu-sed' 'grep' 'gnu-tar' 'gnu-which')
    MANPATH=''
    for name in ${gnu_names[@]}; do
        export PATH="/usr/local/opt/${name}/libexec/gnubin:$PATH"
        export MANPATH="/usr/local/opt/${name}/libexec/gnuman:$MANPATH"
    done

    # Add LaTeX and git binaries
    export PATH="$PATH:/Library/TeX/texbin"          # LaTeX
    export PATH="$PATH:/usr/local/git/bin"           # git

    # Add MATLAB binaries to path (for mlint, etc.)
    export PATH="$PATH:/Applications/MATLAB_R2018a.app/bin"

    export TF_CPP_MIN_LOG_LEVEL=2   # ignore some tensorflow warnings

    # Include my own python utility scripts
    export PYTHONPATH="$PYTHONPATH:$HOME/src/python/util"

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/bernardroesler/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/bernardroesler/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/bernardroesler/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/bernardroesler/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<

    # brew doctor needs this line as of El Cap update 11/17/15
    export LC_ALL=en_US.UTF-8  

    # Shortcuts to directories
    export MAT="$HOME/Documents/MATLAB/"              # path to Matlab files

    # mit-scheme set-up
    export MIT_SCHEME_EXE='/usr/local/bin/mit-scheme'
    # export MIT_SCHEME_EXE='/Applications/MIT-Scheme.app/Contents/Resources/mit-scheme'
    export MITSCHEME_LIBRARY_PATH='/usr/local/lib/mit-scheme-c/'

    # ensure tmux uses colors (not sure if I need this on babylon/polaris?)
    export TERM='screen-256color'
    ;;
esac

# Add my local files
export PATH="$PATH:$HOME/bin"
export SAVE_PATH=$PATH

# default less options (-A fails on older versions)
case "$host" in
polaris)
    export LESS=-XFirsx8g
    ;;
*)
    export LESS=-AXFirsx8g
    ;;
esac

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


