#===============================================================================
#     File: ~/.zprofile
#  Created: 2024-02-29 23:21
#   Author: Bernie Roesler
#
#  Description: Loads for all login shells. Sets path variable and others
#===============================================================================

case "$(hostname -s)" in
Bernard-MBP)
    # Set up homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    export TERM='tmux-256color'    # required by tmux for italics

    # Add coreutils from homebrew, i.e. $(brew --prefix coreutils)
    brew_prefix="$(brew --prefix)"
    gnu_names=('coreutils' 'ed' 'findutils' 'gnu-sed' 'grep' 'gnu-tar' 'gnu-which')
    MANPATH=''
    for name in ${gnu_names[@]}; do
        typeset -TUgx PATH="${brew_prefix}/opt/${name}/libexec/gnubin:$PATH" path
        typeset -TUgx MANPATH="${brew_prefix}/opt/${name}/libexec/gnuman:$MANPATH" manpath
    done

    # Add zsh functions
    export FPATH="${brew_prefix}/share/zsh/site-functions":$FPATH fpath

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
    ;;
esac

# Add my local files
if [[ -d "$HOME/bin" ]]; then
    typeset -TUgx PATH="$PATH:$HOME/bin" path
fi
export SAVE_PATH=$PATH  # keep the default path for reference

# default less options (-A fails on older versions)
export LESS=-AXFirsx8g

#==============================================================================
#==============================================================================
# vim: ft=sh syntax=sh
