#!/bin/bash
#===============================================================================
#     File: ~/.bash_profile
#  Created: 10/29/13
#   Author: Bernie Roesler
#
#  Description: Loads for all login shells. Sets path variable and others
#===============================================================================

host=$(hostname -s)  # i.e. 't1854', 'babylon', 'polaris'

# Only on my Macbook, assumed ok on other machines
case "$host" in
t1854)
    export ARCHFLAGS="-arch x86_64"  # set architecture flags for compilers
    export TERM='screen-256color'    # required by tmux

    export DEFAULT_PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
    export PATH="$DEFAULT_PATH:/opt/X11/bin"

    # Add coreutils from homebrew, i.e. $(brew --prefix coreutils)
    gnu_names=('coreutils' 'ed' 'findutils' 'gnu-sed' 'grep' 'gnu-tar' 'gnu-which')
    MANPATH=''
    for name in ${gnu_names[@]}; do
        export PATH="/usr/local/opt/${name}/libexec/gnubin:$PATH"
        export MANPATH="/usr/local/opt/${name}/libexec/gnuman:$MANPATH"
    done

    export PATH="$PATH:/Library/TeX/texbin"                  # LaTeX path
    export PATH="$PATH:/Applications/MATLAB_R2018a.app/bin"  # for mlint, etc.
    ;;
esac

# Add my local files
export PATH="$PATH:$HOME/bin"
export SAVE_PATH=$PATH  # keep the default path for reference

# default less options (-A fails on older versions)
export LESS=-AXFirsx8g

# Save OLDPWD between sessions
if [ -r "$HOME/.oldpwd" ]; then
    read -r OLDPWD < "$HOME/.oldpwd"
    export OLDPWD

    # add to stack without changing into it, so 'cd -' works
    pushd -n "$OLDPWD" > /dev/null
fi

# Load .bashrc file for interactive shells
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
#==============================================================================
#==============================================================================
# vim: ft=sh syntax=sh
