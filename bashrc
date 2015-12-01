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
#   in order to use shopt -s expand_aliases, and access aliases within vim,
#   need to allow .bashrc to run for non-interactive shells!
# [ -z "$PS1" ] && return

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Set the prompt with bright green text -- include GNU screen window number
  PS1=$"\[\e[00;32m\][\u@\h: \w]${WINDOW}\$ \[\e[0m\]"

  # As of bash 4.3, can trim directories in prompt!
  PROMPT_DIRTRIM=3

elif [[ "$OSTYPE" == "linux"* ]]; then
  # Set to bright cyan text for linux machines (easy tell on ssh to babylons)
  PS1=$"\[\e[00;36m\][\u@\h: \w]${WINDOW}\$ \[\e[0m\]"

  # As of bash 4.3, can trim directories in prompt!
  PROMPT_DIRTRIM=2

else
  # default no color
  PS1=$"[\u@\h: \W]\$ "
fi

# Set the default editor to vim.
export EDITOR=vim

# Avoid succesive duplicates and spaces in the bash command history, ignore
# simple, commonly-used commands.
export HISTCONTROL=ignoredups:ignorespace
export HISTIGNORE='clc:fg:git st:git lol'
export HISTSIZE=$((1 << 12))                # 4096 lines in memory
export HISTFILESIZE=$((1 << 24))            # 16e6 lines in file

# shoptions
shopt -s autocd         # just type directory name to cd
shopt -s cdspell        # checks for minor errors in cd typing
shopt -s checkjobs      # displays stopped or running job status before exiting
shopt -s checkwinsize   # auto reforemat command output
shopt -s cmdhist        # save multi-line commands in history
shopt -s direxpand      # expand variables in directory complete
shopt -s expand_aliases # expand aliases for use in vim :! commands
shopt -s extglob        # extend glob to regexes i.e. ?(ab)
shopt -s globstar       # allows use of ** (like vim)
shopt -s histappend     # append to ~/.bash_history instead of overwriting
shopt -s no_empty_cmd_completion  # ignore completion on empty line
shopt -s shift_verbose  # warn when trying to shift if nothing is there

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
# setterm -bfreq 0


if [[ "$OSTYPE" == "darwin"* ]]; then
  # Set default printer options
  lpoptions -d m210__bw___thayercups \
            -o Duplex=DuplexNoTumble \
            -o prettyprint \
            -o cpi=14 \
            -o lpi=8 \
            -o page-top=18 \
            -o page-right=18 \
            -o page-bottom=36 \
            -o page-left=36

  # Source history of directories function
  source acd_func.sh
fi

# Source subconfig files
for config in "$HOME"/.bashrc.d/*.bash ; do
  # if [ -f "$config" ]; then
    source "$config"
  # fi
done
unset -v config

#==============================================================================
#==============================================================================
