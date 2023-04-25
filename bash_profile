#!/bin/bash
#===============================================================================
#     File: ~/.bash_profile
#  Created: 10/29/13
#   Author: Bernie Roesler
#
#  Description: Loads for all login shells. Sets path variable and others
#===============================================================================

host=$(hostname -s) # i.e. 't1854', 'babylon', 'polaris'

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

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/bernardroesler/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/Users/bernardroesler/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/Users/bernardroesler/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/Users/bernardroesler/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
    ;;

BROESLER-T480|BROESLER-X13)  # Ubuntu on Windows PC (Lenovo T480 for work)
    export WH='/mnt/c/Users/broesler/'  # path to home directory (C:)
    export MAT="$WH/Documents/MATLAB/"  # path to Matlab files

    # add MATLAB files (mlint.exe, etc.)
    export MATLAB_PATH="/mnt/c/Program Files/MATLAB/R2010a/bin/win64"
    export PATH="$PATH:$MATLAB_PATH"

    # add Star-CCM+ path
    export STAR_PATH="/mnt/c/Program Files/CD-adapco/13.06.012/STAR-CCM+3.06.012/star/bin/"
    export PATH="$PATH:$STAR_PATH"

    # Add Latex path
    export MANPATH="$MANPATH:/usr/local/texlive/2020/texmf-dist/doc/man"
    export INFOPATH="$INFOPATH:/usr/local/texlive/2020/texmf-dist/doc/info"
    
    export TEX_PATH="/usr/local/texlive/2020/bin/x86_64-linux"
    export PATH="$PATH:$TEX_PATH"

    export WINDOWS_PATH='C:\Users\broesler\AppData\Local\Packages\CanonicalGroupLimited.UbuntuonWindows_79rhkp1fndgsc\LocalState\rootfs\home\broesler\'

    # Allow X11 to work
    # WSL 1:
    # export DISPLAY=localhost:0.0
    # WSL 2:
    # see: <https://stackoverflow.com/questions/43397162/show-matplotlib-plots-and-other-gui-in-ubuntu-wsl1-wsl2>
    export DISPLAY=$(grep -oP "(?<=nameserver ).+" /etc/resolv.conf):0.0
    # WSL 2(b):
    # export DISPLAY=$(route.exe print | grep 0.0.0.0 | head -1 | awk '{print $4}'):0.0

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/broesler/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/broesler/miniconda3/etc/profile.d/conda.sh" ]; then
            . "/home/broesler/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/broesler/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
    # <<< conda initialize <<<
    ;;
esac

# Add my local files
export PATH="$PATH:$HOME/bin"
export SAVE_PATH=$PATH  # keep the default path for reference

# default less options (-A fails on older versions)
export LESS=-AXFirsx8g

# Save OLDPWD between sessions
if [ -r ~/.oldpwd ]; then
    read -r OLDPWD < ~/.oldpwd
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

