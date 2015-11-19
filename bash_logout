#~/.bash_logout
# Set vim syntax: vim:ft=sh syntax=sh
#==============================================================================
#    File: ~/.bash_logout
# Created: 11/19/2015, 00:58 
#  Author: Bernie Roesler
#
# Description: commands to be executed upon logout
#==============================================================================

# save OLDPWD between sessions
if [ -r "${OLDPWD_FILE:-$HOME/.oldpwd}" ]; then
  echo "$PWD" > ~/.oldpwd
fi

clear
#==============================================================================
#==============================================================================
