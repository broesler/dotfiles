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
        export PATH="${brew_prefix}/opt/${name}/libexec/gnubin:$PATH"
        export MANPATH="${brew_prefix}/opt/${name}/libexec/gnuman:$MANPATH"
    done

    ;;
esac

# Add my local files
export PATH="$PATH:$HOME/bin"
export SAVE_PATH=$PATH  # keep the default path for reference

# default less options (-A fails on older versions)
# export LESS=-AXFirsx8g

# Save OLDPWD between sessions
# if [ -r "$HOME/.oldpwd" ]; then
#     read -r OLDPWD < "$HOME/.oldpwd"
#     export OLDPWD

#     # add to stack without changing into it, so 'cd -' works
#     pushd -n "$OLDPWD" > /dev/null
# fi

# # Load .zshrc file for interactive shells
# if [ -f ~/.zshrc ]; then
#     source ~/.zshrc
# fi

#==============================================================================
#==============================================================================
# vim: ft=sh syntax=sh
