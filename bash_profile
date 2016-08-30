#!/bin/bash
# Set vim syntax: vim:ft=sh syntax=sh
#==============================================================================
#    File: ~/.bash_profile
# Created: 10/29/13
#  Author: Bernie Roesler
#
# Last Modified: 05/20/2016, 17:37
#
# Description: Loads for all login shells. Sets path variable and others
#==============================================================================

# Only on OSX, assumed OK on babylon machines
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Set architecture flags for compilers
  export ARCHFLAGS="-arch x86_64"

  # Default PATH
  export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin"

  #----- Ruby setup:
  # Load RVM into a shell session *as a function*
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
  export PATH="$PATH:$HOME/.rbenv/shims"
  eval "$(rbenv init -)"
  export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
  export PATH="$PATH:/usr/local/heroku/bin"

  # Set PATH variable correctly (last line is at front of path)
  export PATH="$PATH:/Library/TeX/texbin"          # LaTeX
  export PATH="$PATH:/usr/local/git/bin"           # git

  # Add MATLAB binaries to path
  export PATH="$PATH:/Applications/MATLAB_R2015b.app/bin"

  export LC_ALL=en_US.UTF-8                   # brew doctor needs this line as of El Cap update 11/17/15 
  export RES=~/Documents/School/Research/     # path to research folder
  export STY=~/Library/texmf/tex/latex/       # path to latex style files
  export MAT=~/Documents/MATLAB/              # path to Matlab files
fi

# ensure tmux uses colors
export TERM='screen-256color'               

# less highlighting for man pages
export LESS_TERMCAP_so=$'\e[30;47m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS=-Airsx8g

# # Use vim as man pager -- nicer searching, but SLOW to load vs less
# export MANPAGER="/bin/sh -c \"col -b | vim -c 'set ft=man ts=8 nomod nolist nonu noma' \
#                                            -c 'nnoremap i <nop>' \
#                                            -c 'nnoremap <Space> <C-f>' \
#                                            -c 'noremap q :quit<CR>' -\""

# If we can read ~/.oldpwd, make its contents our OLDPWD
# saves OLDPWD between sessions
if [ -r "$HOME/.oldpwd" ]; then
  read -r OLDPWD < "$HOME/.oldpwd"
  export OLDPWD

  # add to stack without changing into it, so 'cd -' works
  pushd -n "$OLDPWD" > /dev/null
fi

#------------------------------------------------------------------------------
#       Load .bashrc file for interactive shells
#------------------------------------------------------------------------------
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
#==============================================================================
#==============================================================================
