#~/.bash_profile
# Set vim syntax: vim:ft=sh syntax=sh
#==============================================================================
#    File: ~/.bash_profile
# Created: 10/29/13
#  Author: Bernie Roesler
#
# Description: Loads for all login shells. Sets path variable and others
#==============================================================================

# Only on OSX, assumed OK on babylon machines
if [[ "$OSTYPE" == "darwin"* ]]; then
  # Set architecture flags
  export ARCHFLAGS="-arch x86_64"

  # Ruby setup:
  [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

  eval "$(rbenv init -)"
  export PATH="$HOME/.rbenv/shims:$PATH"
  export PATH="/usr/local/heroku/bin:$PATH"

  # Set PATH variable correctly (last line is at front of path)
  export PATH="/usr/texbin:$PATH"                  # Add texbin to path for LaTeX usage
  export PATH="/usr/local/git/bin:$PATH"           # Enable git
  export PATH="/usr/local/bin:$PATH"               # Enable homebrew 

  # Set system-wide variables
  export LC_ALL=C                             # Allow sort to produce expected behavior
  export RES=~/Documents/School/Research/     # path to research folder
  export STY=~/Library/texmf/tex/latex/       # path to latex style files
fi

# ensure tmux uses colors
export TERM='screen-256color'               

#------------------------------------------------------------------------------
# If I have my own init file, then use that one, else use the
# canonical one.
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
#==============================================================================
