#~/.zshrc
#==============================================================================
#    File: ~/.zshrc
# Created: 2024-02-29 23:32
#  Author: Bernie Roesler
#
# Description: Contains aliases and settings for use with the zsh shell
#==============================================================================

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

case "$(hostname -s)" in
Bernards-MBP)
    # Enable git in the prompt
    autoload -Uz vcs_info
    precmd_vcs_info() { vcs_info }
    precmd_functions+=( precmd_vcs_info )
    setopt PROMPT_SUBST
    RPS1='${vcs_info_msg_0_}'
    zstyle ':vcs_info:git:*' formats '%F{purple}%a%f (%b)%m%u%c'
    zstyle ':vcs_info:*' enable git

    # Set the prompt with bold green text
    PS1="%B%F{green}%3~ %# %f%b"
    ;;
*)
    # default no color
    PS1="%n@%m %1~ %# "
    ;;
esac

# If in ssh session, change the prompt
if [[ -n "$SSH_CLIENT" ]]; then
    echo "Welcome to $(scutil --get ComputerName) ($(sw_vers --productVersion))"
    PS1="%B%F{cyan}[%n@%m %3~] %# %f%b"
fi

# Enable vim-style editing in terminal (also see ~/.inputrc)
export EDITOR=vim  # Set the default editor to vim.
bindkey -v

# Avoid succesive duplicates and spaces in the bash command history, ignore
# simple, commonly-used commands. No need to "export", these are only used in
# interactive shells
HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history

SAVEHIST=$((1 << 12))  # 4096 lines in memory
HISTSIZE=$((1 << 24))  # 16e6 lines in file

setopt EXTENDED_HISTORY    # include timestamp and elapsed time
setopt INC_APPEND_HISTORY  # append to history as commandas are entered
setopt SHARE_HISTORY       # share history across multiple sessions
setopt HIST_IGNORE_DUPS    # do not save lines if they are duplicates
setopt HIST_IGNORE_SPACE   # remove command from history with leading space

# TODO test me:
HISTIGNORE='(clc|clear|[bf]g|git st|git lol|history|h|hr|k)'

# Shell options
setopt AUTO_CD        # don't need `cd` before a path, replaces '..' alias.
setopt AUTO_PUSHD     # keep all directories on the stack for each changing
setopt ALIASES        # expand aliases (needed for vim :!)
setopt NO_CASE_GLOB   # ignore case for globbing and completion
setopt CHECK_JOBS     # displays stopped or running job status before exiting
setopt CORRECT_ALL  # try to correct all options
setopt EXTENDED_GLOB  # extend glob to regexes ^,#,~

# ----------------------------------------------------------------------------- 
#         Completion options
# -----------------------------------------------------------------------------
autoload -Uz compinit && compinit
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix


# less highlighting for man pages:
# NOTE: do not actually use "tput bold" because iTerm uses "bright" colors,
# which in Solarized scheme are just grayscale other than red
# export LESS_TERMCAP_mb=$(tput setaf 2)            # start blink
# export LESS_TERMCAP_md=$(tput setaf 3)            # start bold
# export LESS_TERMCAP_me=$(tput sgr0)               # end bold/blink
# export LESS_TERMCAP_us=$(tput smul; tput setaf 4) # start underline
# export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)    # end underline
# export LESS_TERMCAP_so=$(tput setaf 0; tput setab 3) # start highlight
# export LESS_TERMCAP_se=$(tput sgr0) # end highlight

# Anaconda include
# if ! command -v conda &> /dev/null; then
#     conda activate stats311 2> /dev/null
# fi

#------------------------------------------------------------------------------
#       Source function files and aliases
#------------------------------------------------------------------------------
# for func in "$HOME"/.bashrc.d/*.bash ; do
#     if [ -f "$func" ]; then
#         source "$func"
#     fi
# done
# unset -v func

#==============================================================================
#==============================================================================
# vim: ft=sh syntax=sh
