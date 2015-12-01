#===============================================================================
#     File: run_matlab_tmux.bash
#  Created: 11/25/2015, 19:28
#   Author: Bernie Roesler
#
# Last Modified: 12/01/2015, 14:50
#
#  Description: Run Matlab script from tmux 
#===============================================================================
run_matlab_tmux()
{
  # First check if TMUX is running
  if [ -n "$TMUX" ]; then
    # See if matlab is running in this tmux window
    tmuxswp=$(tpg "[A]pplications/MATLAB")

    #---------------------------------------------------------------------------
    #       Determine how to run matlab
    #---------------------------------------------------------------------------
    # Use arguments if we have them
    # if matlab is running, use $msid:$mwid.$mpid as target pane
    if [ -n "$tmuxswp" ]; then
      if (($#)); then
        # tmux send-keys -t "$msid:$mwid.$mpid" "$@" C-m
        tmux send-keys -t "$tmuxswp" "$@" C-m
      else
        # move to pane with instance of matlab
        # echo "Matlab is running in $mtty, tmux session: $tmuxswp"
        tmux select-pane -t "$tmuxswp" 
      fi
    else
      # use bottom-left as default
      if (($#)); then
        # open matlab first, then send the command
        tmux send-keys -t bottom-left 'matlab -nosplash -nodesktop' C-m
        tmux send-keys -t bottom-left "$@" C-m
      else
        # if no arguments given, open MATLAB in bottom-left tmux pane
        tmux send-keys -t bottom-left 'matlab -nosplash -nodesktop' C-m
      fi
    fi

  else
    echo 'Usage: run_matlab_tmux() must be run inside tmux session.' 1>&2
    return 1
  fi

  return 0
}
#===============================================================================
#===============================================================================
