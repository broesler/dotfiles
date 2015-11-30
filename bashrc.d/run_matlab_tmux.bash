#===============================================================================
#     File: run_matlab_tmux.bash
#  Created: 11/25/2015, 19:28
#   Author: Bernie Roesler
#
# Last Modified: 11/26/2015, 00:29
#
#  Description: Run Matlab script from tmux 
#===============================================================================
run_matlab_tmux()
{
  # First check if TMUX is running
  if [ -n "$TMUX" ]; then
    #---------------------------------------------------------------------------
    #       See if matlab is running in this tmux window
    #---------------------------------------------------------------------------
    tmuxswp=$(tpg "[A]pplications/MATLAB")

    # # list pane tty, window id, pane id:
    # #   /dev/ttys001 $1 @5 %10 /dev/ttys002 $1 @5 %12
    # lsp=$(tmux list-panes -F "#{pane_tty} #{session_id} #{window_id} #{pane_id}")
    #
    # # read ttys, windows, panes into array
    # read -r -a panetty  <<< $(echo "$lsp" | \grep -o "tty.[0-9]\{3\}")
    # read -r -a sessid   <<< $(echo "$lsp" | \grep -o "\$[0-9]\+")
    # read -r -a windowid <<< $(echo "$lsp" | \grep -o "@[0-9]\+")
    # read -r -a paneid   <<< $(echo "$lsp" | \grep -o "%[0-9]\+")
    #
    # # NOTE: to do the same without Perl regex (-P), need to do 2 greps to
    # #   ensure you are getting what is immediately following tty.:
    # # read -r -a panetty  <<< $(echo "$lsp" | \grep -o "tty.[0-9]\{3\}" | \grep -o "[0-9]\{3\}")
    #
    # # Build regex pattern to search all tty's
    # pat="("
    # i=1
    # for pane in ${panetty[@]}; do
    #   pat+=$pane
    #   if [ "$i" -ne "${#panetty[@]}" ]; then
    #     pat+='|'
    #   fi
    #   let i+=1
    # done 
    # pat+=')'
    #
    # # grep for matlab running in one of the pane tty's
    # test=$(\ps | \egrep "$pat" | \grep  "[A]pplications/MATLAB")
    #
    # # extract tty of pane running matlab
    # mtty=$(echo "$test" | \grep -o "tty.[0-9]\{3\}")
    #
    # # find array index matching mtty
    # i=0
    # for k in ${panetty[@]}; do
    #     if [ "$k" == "$mtty" ]; then
    #       mind=$i
    #     fi
    #     let i+=1
    # done
    #
    # # extract window and pane id's (window is current window)
    # msid=${sessid[$mind]}
    # mwid=${windowid[$mind]}
    # mpid=${paneid[$mind]}

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
        # echo "Matlab is running in $mtty, tmux session: $msid:$mwid.$mpid."
        # tmux select-pane -t "$msid:$mwid.$mpid" 
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
    echo 'Usage: run_matlab_tmux() must be run inside tmux session.' 2>&1
    return 1
  fi

  return 0
}
#===============================================================================
#===============================================================================
