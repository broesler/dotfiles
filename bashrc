#~/.bashrc
#==============================================================================
#    File: ~/.bashrc
# Created: 10/29/13
#  Author: Bernie Roesler
#
# Description: Contains aliases and settings for use with the bash shell
#==============================================================================

host=$(hostname -s) # i.e. 't1854', 'babylon', 'polaris'

# If not running interactively, don't do anything
# in order to use shopt -s expand_aliases, and access aliases within vim,
# need to allow .bashrc to run for non-interactive shells!
# ...OR `export -f' all functions required in vim!
[ -z "$PS1" ] && return

case "$host" in
t1854)
    # Set the prompt with bright green text -- include GNU screen window number
    PS1=$"\[\033[1;32m\][\u@\h: \w]${WINDOW}\$ \[\033[0m\]"
    ;;
babylon*|polaris|BROESLER*)
    # Set to bright cyan text for linux machines (easy tell on ssh to babylons)
    PS1=$"\[\033[0;36m\][\u@\h: \w]${WINDOW}\$ \[\033[0m\]"
    ;;
*)
    # default no color
    PS1=$"[\u@\h: \W]\$ "
    ;;
esac

PROMPT_DIRTRIM=4  # uses '...' to limit list of directories

export EDITOR=vim                     # Set the default editor to vim.
export PGDATABASE=postgres            # Default postgresql database for psql

# Avoid succesive duplicates and spaces in the bash command history, ignore
# simple, commonly-used commands. No need to "export", these are only used in
# interactive shells
HISTCONTROL=ignoredups:ignorespace
HISTIGNORE='clc:[bf]g:git st:git lol:history:h:hr:k'
HISTSIZE=$((1 << 12))                # 4096 lines in memory
HISTFILESIZE=$((1 << 24))            # 16e6 lines in file
HISTTIMEFORMAT="%F %T "

# Append commands to the history every time a prompt is shown,
# instead of after closing the session.
PROMPT_COMMAND='history -a'

# shoptions
shopt -s checkjobs       # displays stopped or running job status before exiting
shopt -s checkwinsize    # auto reformat command output
shopt -s cmdhist         # save multi-line commands in history
if [[ ${BASH_VERSINFO[1]} > 1 ]]; then
    shopt -s direxpand      # expand variables in directory complete
fi
shopt -s expand_aliases  # expand aliases (needed for vim :!)
shopt -s extglob         # extend glob to regexes i.e. ?(ab)
shopt -s globstar        # allows use of ** (like vim)
shopt -s histappend      # append to ~/.bash_history instead of overwriting
shopt -s no_empty_cmd_completion  # ignore completion on empty line
shopt -s shift_verbose   # warn when trying to shift if nothing is there

# Completion options
set match-hidden-files off

# Turn off <C-S> flow control (stops all I/O until <C-Q> is pressed)
stty -ixon

# Enable vim-style editing in terminal (also see ~/.inputrc)
set -o vi

# Visual bell only
set bell-style visible

# enable better auto-completion
if [ -f '/usr/local/etc/bash_completion' ]; then
    source '/usr/local/etc/bash_completion'
fi

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

#------------------------------------------------------------------------------
#       Source function files and aliases
#------------------------------------------------------------------------------
for func in "$HOME"/.bashrc.d/*.bash ; do
    if [ -f "$func" ]; then
        source "$func"
    fi
done
unset -v func

#==============================================================================
#==============================================================================
