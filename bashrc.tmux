#~/.bashrc.tmux
# Set vim syntax: vim: set ft=sh syntax=sh
#==============================================================================
#    File: ~/.bashrc.tmux
# Created: 12/17/2015, 14:03 
#  Author: Bernie Roesler
#
# Description: Run only when running ssh inside of tmux session
#==============================================================================

# Source actual bashrc
if [ -f ~/.bashrc ]; then
  echo sourcing bashrc
  source ~/.bashrc
fi

# additionally, set variable to ssh knows it's inside of tmux
export SSH_IN_TMUX=true

#==============================================================================
#==============================================================================
