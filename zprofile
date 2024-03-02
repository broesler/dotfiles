#===============================================================================
#     File: ~/.zprofile
#  Created: 2024-02-29 23:21
#   Author: Bernie Roesler
#
#  Description: Loads for all login shells. Sets path variable and others
#===============================================================================

case "$(hostname -s)" in
Bernards-MBP)
    # Set up homebrew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # export TERM='screen-256color'    # required by tmux?

    # Add coreutils from homebrew, i.e. $(brew --prefix coreutils)
    brew_prefix="$(brew --prefix)"
    gnu_names=('coreutils' 'ed' 'findutils' 'gnu-sed' 'grep' 'gnu-tar' 'gnu-which')
    MANPATH=''
    for name in ${gnu_names[@]}; do
        typeset -TUgx PATH="${brew_prefix}/opt/${name}/libexec/gnubin:$PATH" path
        typeset -TUgx MANPATH="${brew_prefix}/opt/${name}/libexec/gnuman:$MANPATH" manpath
    done

    # Add zsh functions
    typeset -TUgx FPATH="${brew_prefix}/share/zsh/site-functions":$FPATH fpath

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
