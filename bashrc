#~/.bashrc
# vim: set ft=sh syntax=sh
#==============================================================================
#    File: ~/.bashrc
# Created: 10/29/13
#  Author: Bernie Roesler
#
# Description: Contains aliases and simple functions for use with the bash shell
#==============================================================================

# If not running interactively, don't do anything
#+ in order to use shopt -s expand_aliases, and access aliases within vim,
#+ need to allow .bashrc to run for non-interactive shells!
#+ ...OR `export -f' all functions required in vim!
[ -z "$PS1" ] && return

if [[ "$OSTYPE" == "darwin"* ]]; then
  # Set the prompt with bright green text -- include GNU screen window number
  PS1=$"\[\e[01;32m\][\u@\h: \w]${WINDOW}\$ \[\e[0m\]"
  # PS1=$"[\u@\h: \w]${WINDOW}\$ "

  # As of bash 4.3, can trim directories in prompt!
  PROMPT_DIRTRIM=3

elif [[ "$OSTYPE" == "linux"* ]]; then
  # Set to bright cyan text for linux machines (easy tell on ssh to babylons)
  PS1=$"\[\e[01;36m\][\u@\h: \w]${WINDOW}\$ \[\e[0m\]"

  # As of bash 4.3, can trim directories in prompt!
  PROMPT_DIRTRIM=3

else
  # default no color
  PS1=$"[\u@\h: \W]\$ "
fi

# Set CDPATH to quickly change to neighbor directories
CDPATH=".:..:../..:$HOME"

# Set the default editor to vim.
export EDITOR=vim

# Avoid succesive duplicates and spaces in the bash command history, ignore
#+ simple, commonly-used commands.
export HISTCONTROL=ignoredups:ignorespace
export HISTIGNORE='clc:bg:fg:git st:git lol:history:h:hr'
export HISTSIZE=$((1 << 12))                # 4096 lines in memory
export HISTFILESIZE=$((1 << 24))            # 16e6 lines in file
export HISTTIMEFORMAT="%F %T "

# shoptions
shopt -s autocd         # just type directory name to cd
shopt -s cdspell        # checks for minor errors in cd typing
shopt -s checkjobs      # displays stopped or running job status before exiting
shopt -s checkwinsize   # auto reforemat command output
shopt -s cmdhist        # save multi-line commands in history
shopt -s direxpand      # expand variables in directory complete
shopt -s expand_aliases # expand aliases (needed for vim :!)
shopt -s extglob        # extend glob to regexes i.e. ?(ab)
shopt -s globstar       # allows use of ** (like vim)
shopt -s histappend     # append to ~/.bash_history instead of overwriting
shopt -s no_empty_cmd_completion  # ignore completion on empty line
shopt -s shift_verbose  # warn when trying to shift if nothing is there

# Completion options
set match-hidden-files off

# Append commands to the history every time a prompt is shown,
#+ instead of after closing the session.
PROMPT_COMMAND='history -a'

# Turn off <C-S> flow control (stops all I/O until <C-Q> is pressed)
stty -ixon

# Enable vim-style editing in terminal
set -o vi

# Visual bell only
set bell-style visible

# Mac-only options
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Create instance of m210 B/W printer for duplex printing
  lpoptions -p m210__bw___thayercups/duplex \
            -o Duplex=DuplexNoTumble \
            -o prettyprint \
            -o cpi=14 \
            -o lpi=8 \
            -o page-top=18 \
            -o page-right=18 \
            -o page-bottom=36 \
            -o page-left=36

  lpoptions -p m210__color___thayercups/duplex \
            -o Duplex=DuplexNoTumble \
            -o prettyprint \
            -o cpi=14 \
            -o lpi=8 \
            -o page-top=18 \
            -o page-right=18 \
            -o page-bottom=36 \
            -o page-left=36

  # enable better auto-completion
  if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
  fi

  # Disable tilde expansion upon tab completion
  _expand() { return 0; }

  # Run iTerm2 shell integration
  test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
fi

# fix vim autocompletion
complete -r vim

#-------------------------------------------------------------------------------
# Source function files and aliases
#-------------------------------------------------------------------------------
for func in "$HOME"/.bashrc.d/*.bash ; do
  if [ -f "$func" ]; then
    source "$func"
  fi
done
unset -v func

#==============================================================================
#==============================================================================
