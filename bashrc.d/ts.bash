#===============================================================================
#     File: ts.bash
#  Created: 11/25/2015, 19:28
#   Author: Bernie Roesler
#
# Last Modified: 12/01/2015, 14:42
#
#  Description: Shortcut for tmux send-keys to bottom-left
#  Usage: ts [-t target_pane] 'keys to send'
#         "ts 'ls -l'" runs 'ls -l' in bottom-left pane of current window
#===============================================================================
ts()
{
  if [ -n "$TMUX" ]; then
      args=$@
      tmux send-keys -t bottom-left "$args" C-m
  else
    echo "Usage: tmux must be running to use send-keys!" 1>&2
    return 1
  fi

  return 0
}
#===============================================================================
#===============================================================================
