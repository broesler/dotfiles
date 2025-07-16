#===============================================================================
#     File: ~/.zprofile
#  Created: 2024-02-29 23:21
#   Author: Bernie Roesler
#
#  Description: Loads for all login shells. Sets path variable and others
#===============================================================================

case "$(hostname -s)" in
(Bernard-MBP | Mac)
    # Set up homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    if [[ -n "$TMUX" ]]; then
        export TERM='tmux-256color'    # required by tmux for italics
    fi

    # Add coreutils from homebrew, i.e. $(brew --prefix coreutils)
    brew_prefix="/opt/homebrew"

    export PATH="${brew_prefix}/bin:${brew_prefix}/sbin:$PATH"

    gnu_names=('coreutils' 'ed' 'findutils' 'gnu-sed' 'grep' 'gnu-tar' 'gnu-which')
    MANPATH=''
    for name in ${gnu_names[@]}; do
        typeset -TUgx PATH="${brew_prefix}/opt/${name}/libexec/gnubin:$PATH" path
        typeset -TUgx MANPATH="${brew_prefix}/opt/${name}/libexec/gnuman:$MANPATH" manpath
    done

    # Add zsh functions
    typeset -TUgx FPATH="${brew_prefix}/share/zsh/site-functions:$FPATH" fpath

    # >>> conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/Users/bernardroesler/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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
    
    # C compilation flags for Homebrew llvm
    export PATH="${brew_prefix}/opt/llvm/bin:$PATH"
    export LDFLAGS="-L${brew_prefix}/opt/llvm/lib"
    export CPPFLAGS="-I${brew_prefix}/opt/llvm/include"
    # export ASAN_OPTIONS=detect_leaks=1  # XXX not supported on MacOS
    
    # Allow Octave to find the Homebrew version of liboctinterp for compiling
    # CSparse and other mexfunctions
    octlib="$(find ${brew_prefix} -name 'liboctinterp.*' -print -quit)"
    export LDFLAGS="${LDFLAGS} -L$(dirname $octlib)"
    unset -v octlib

    export PATH="$PATH:/Applications/MATLAB_R2025a.app/bin"         # for matlab, etc.
    export PATH="$PATH:/Applications/MATLAB_R2025a.app/bin/maca64"  # for mlint
    export PATH="/Users/bernardroesler/.pixi/bin:$PATH"
    ;;
esac

# Add my local files
if [[ -d "$HOME/bin" ]]; then
    typeset -TUgx PATH="$PATH:$HOME/bin" path
fi
export SAVE_PATH=$PATH  # keep the default path for reference

# default less options (-A fails on older versions)
export LESS=-AXFirsx8g

#------------------------------------------------------------------------------
#       Source function files
#------------------------------------------------------------------------------
funcs=$HOME/.zshfunctions
typeset -TUgx FPATH=$funcs:$FPATH fpath  # only unique entries
if [[ -d $funcs ]]; then
    autoload -Uz ${=$(cd "$funcs" && echo *)}
fi
unset -v funcs

#==============================================================================
#==============================================================================
# vim: ft=zsh syntax=zsh
