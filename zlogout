#~/.zsh_logout
#==============================================================================
#    File: ~/.zsh_logout
# Created: 2024-03-01 22:51
#  Author: Bernie Roesler
#
# Description: commands to be executed upon logout
#==============================================================================

# save OLDPWD between sessions
if [ -r "$HOME/.oldpwd" ]; then
  echo "$PWD" > "$HOME/.oldpwd"
fi

clear
#==============================================================================
#==============================================================================
# vim:ft=sh syntax=sh
