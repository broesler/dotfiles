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
babylon*|polaris)
    # Set to bright cyan text for linux machines (easy tell on ssh to babylons)
    PS1=$"\[\033[0;36m\][\u@\h: \w]${WINDOW}\$ \[\033[0m\]"
    ;;
*)
    # default no color
    PS1=$"[\u@\h: \W]\$ "
    ;;
esac

# uses '...' to limit list of directories
PROMPT_DIRTRIM=4

# Set CDPATH to quickly change to neighbor directories
CDPATH=".:..:../..:$HOME"

# Set the default editor to vim.
export EDITOR=vim

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
shopt -s autocd         # just type directory name to cd
shopt -s cdspell        # checks for minor errors in cd typing
shopt -s checkjobs      # displays stopped or running job status before exiting
shopt -s checkwinsize   # auto reforemat command output
shopt -s cmdhist        # save multi-line commands in history
if [[ ${BASH_VERSINFO[1]} > 1 ]]; then
    shopt -s direxpand      # expand variables in directory complete
fi
shopt -s expand_aliases # expand aliases (needed for vim :!)
shopt -s extglob        # extend glob to regexes i.e. ?(ab)
shopt -s globstar       # allows use of ** (like vim)
shopt -s histappend     # append to ~/.bash_history instead of overwriting
shopt -s no_empty_cmd_completion  # ignore completion on empty line
shopt -s shift_verbose  # warn when trying to shift if nothing is there

# Completion options
set match-hidden-files off

# Turn off <C-S> flow control (stops all I/O until <C-Q> is pressed)
stty -ixon

# Enable vim-style editing in terminal (also see ~/.inputrc)
set -o vi

# Visual bell only
set bell-style visible

# Mac-only options
if [[ "$host" = t1854 ]]; then
    # enable better auto-completion
    if [ -f '/usr/local/etc/bash_completion' ]; then
        source '/usr/local/etc/bash_completion'
    fi

    # Disable tilde expansion upon tab completion
    _expand() { return 0; }

    # Run iTerm2 shell integration
    # test -e "${HOME}/.iterm2_shell_integration.bash" \
        # && source "${HOME}/.iterm2_shell_integration.bash"

    # fix vim autocompletion
    complete -r vim

    # Set-up virtualenv wrapper for python development
    vewrap="$(brew --prefix)/bin/virtualenvwrapper.sh"
    if [ -f "$vewrap" ]; then
        export WORKON_HOME="$HOME/.envs"
        source "$vewrap"
    fi
fi

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
# vim: set ft=sh syntax=sh
