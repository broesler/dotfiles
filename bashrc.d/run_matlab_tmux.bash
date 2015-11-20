# Run Matlab script from tmux
run_matlab_tmux()
{
  if (($#)) ; then
    # if matlab is already running (assume it's in TMUX for now...)
    if [ -n "$(ps | grep "[/]Applications/MATLAB")" ]; then
      tmux send-keys -t bottom-left "$@" C-m
    else
      # open matlab first, then send the command
      tmux send-keys -t bottom-left 'matlab -nosplash -nodesktop' C-m
      tmux send-keys -t bottom-left "$@" C-m
    fi
  else
    # if no arguments given, open MATLAB in bottom-left tmux pane
    tmux send-keys -t bottom-left 'matlab -nosplash -nodesktop' C-m
  fi
}
