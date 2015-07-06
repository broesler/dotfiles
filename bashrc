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

# Avoid succesive duplicates and spaces in the bash command history, ignore
# simple, commonly-used commands.
export HISTCONTROL=ignoredups:ignorespace
export HISTIGNORE='clc:lc:fg:git st:git lol'
export HISTSIZE=10000
export HISTFILESIZE=100000

# shoptions
shopt -s autocd         # just type directory name to cd
shopt -s cdspell        # checks for minor errors in cd typing
shopt -s checkjobs      # displays stopped or running job status before exiting
shopt -s checkwinsize   # auto reforemat command output
shopt -s cmdhist        # save multi-line commands in history
shopt -s extglob        # extend glob to regexes i.e. ?(ab)
shopt -s globstar       # allows use of ** (like vim)
shopt -s histappend     # append to ~/.bash_history instead of overwriting

# Append commands to the history every time a prompt is shown,
# instead of after closing the session.
PROMPT_COMMAND='history -a'

# Turn off <C-s> terminal shortcut so it works in vim.
# This option will turn back on after vim quits.
stty -ixon

# Enable vim-style editing in terminal
set -o vi

# Visual bell only
set bell-style visible

alias tmux='tmux -2'    # Force tmux to use 256 colors (get solarized right)

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Set printer options to Duplex Long-Edge-Binding, syntax highlighting on
  lpoptions -d m128_1___thayercups \
            -o Duplex=DuplexNoTumble \
            -o prettyprint \
            -o cpi=14 \
            -o lpi=8 \
            -o page-top=18 \
            -o page-right=18 \
            -o page-bottom=36 \
            -o page-left=36
fi

# Add bash aliases.
if [ -f ~/.bash_aliases ]; then
  source ~/.bash_aliases
fi
#==============================================================================

