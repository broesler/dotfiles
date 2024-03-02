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

    export PATH="$PATH:/Library/TeX/texbin"                         # LaTeX path
    export PATH="$PATH:/Applications/MATLAB_R2020a.app/bin"         # for matlab, etc.
    export PATH="$PATH:/Applications/MATLAB_R2020a.app/bin/maci64"  # for mlint

    # Ruby for jekyll
    export LDFLAGS="-L/usr/local/opt/ruby/lib"
    export CPPFLAGS="-I/usr/local/opt/ruby/include"
    export PATH="/usr/local/opt/ruby/bin:$PATH"

    # Need for matplotlib Qt5Agg backend to work on Big Sur
    export QT_MAC_WANTS_LAYER=1

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/bernardroesler/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/bernardroesler/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/bernardroesler/miniconda3/etc/profile.d/conda.sh"  # commented out by conda initialize
        else
            export PATH="/Users/bernardroesler/miniconda3/bin:$PATH"  # commented out by conda initialize
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<

    # C compilation flags
    export CPATH=`xcrun --show-sdk-path`/usr/include
    export LDFLAGS="$LDFLAGS -L/usr/local/opt/llvm/lib"
    export CPPFLAGS="-I/usr/local/opt/llvm/include"
    export ASAN_OPTIONS=detect_leaks=1
    ;;

Bernards-MBP)
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # export TERM='screen-256color'    # required by tmux

    # Add coreutils from homebrew, i.e. $(brew --prefix coreutils)
    brew_prefix="$(brew --prefix)"
    gnu_names=('coreutils' 'ed' 'findutils' 'gnu-sed' 'grep' 'gnu-tar' 'gnu-which')
    MANPATH=''
    for name in ${gnu_names[@]}; do
        export PATH="${brew_prefix}/opt/${name}/libexec/gnubin:$PATH"
        export MANPATH="${brew_prefix}/opt/${name}/libexec/gnuman:$MANPATH"
    done

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
