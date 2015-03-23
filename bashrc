#~/.bashrc
# Set vim syntax: vim: set ft=sh syntax=sh
#==============================================================================
#    File: ~/.bashrc
# Created: 10/29/13
#  Author: Bernie Roesler
#
# Description: Contains aliases and simple functions for use with the bash shell
#==============================================================================

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Set the prompt with bright green text -- include GNU screen window number
  PS1=$"\[\e[01;32m\][\u@\h: \W]${WINDOW}\$ \[\e[m\]"
elif [[ "$OSTYPE" == "linux"* ]]; then
  # Set to bright cyan text for linux machines (easy tell on ssh to babylons)
  PS1=$"\[\e[01;36m\][\u@\h: \W]${WINDOW}\$ \[\e[m\]"
else
  # default
  PS1=$"[\u@\h: \W]\$ "
fi

# Set the default editor to vim.
export EDITOR=vim

# Avoid succesive duplicates and spaces in the bash command history.
export HISTCONTROL=ignoredups:ignorespace
HISTSIZE=10000
HISTFILESIZE=100000

# shoptions
shopt -s histappend     # append to ~/.bash_history instead of overwriting
shopt -s checkwinsize   # auto reforemat command output
shopt -s extglob        # extend glob to regexes i.e. ?(ab)

# Append commands to the history every time a prompt is shown,
# instead of after closing the session.
PROMPT_COMMAND='history -a'

# Turn off <C-s> terminal shortcut so it works in vim.
# This option will turn back on after vim quits.
stty -ixon

# Enable vim-style editing in terminal
set -o vi

alias tmux='tmux -2'    # Force tmux to use 256 colors (get solarized right)

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Set printer options to Duplex Long-Edge-Binding, syntax highlighting on
  lpoptions -d m128_1___thayercups -o Duplex=DuplexNoTumble -o prettyprint

  ### Added by the Heroku Toolbelt
  export PATH="/usr/local/heroku/bin:$PATH"
fi

# Add bash aliases.
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi

#==============================================================================
