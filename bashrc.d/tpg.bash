#===============================================================================
#     File: tpg.bash
#  Created: 11/25/2015, 19:29
#   Author: Bernie Roesler
#
# Last Modified: 12/01/2015, 13:21
#
#  Description: "[t]mux [p]s [g]rep" finds the tmux pane running the process
#===============================================================================
tpg()
{
  if [ -n "$TMUX" ]; then
    pspat="$@"

    # list pane tty, window id, pane id:
    #   /dev/ttys001 $1 @5 %10 /dev/ttys002 $1 @5 %12
    lsp=$(tmux list-panes -F "#{pane_tty} #{session_id} #{window_id} #{pane_id}")

    # read ttys, windows, panes into array
    read -r -a panetty  <<< $(echo "$lsp" | \grep -o "tty.[0-9]\{3\}")
    read -r -a sessid   <<< $(echo "$lsp" | \grep -o "\$[0-9]\+")
    read -r -a windowid <<< $(echo "$lsp" | \grep -o "@[0-9]\+")
    read -r -a paneid   <<< $(echo "$lsp" | \grep -o "%[0-9]\+")

    # NOTE: to do the same without Perl regex (-P), need to do 2 greps to
    #   ensure you are getting what is immediately following tty.:
    # read -r -a panetty  <<< $(echo "$lsp" | \grep -o "tty.[0-9]\{3\}" | \grep -o "[0-9]\{3\}")

    # Build regex pattern to search all tty's
    pat="("
    i=1
    for pane in ${panetty[@]}; do
      pat+=$pane
      if [ "$i" -ne "${#panetty[@]}" ]; then
        pat+='|'
      fi
      let i+=1
    done 
    pat+=')'

    # grep for process running in one of the pane tty's
    # ignore THIS process (grep itself)
    test=$(\ps | \egrep "$pat" | \grep -is "$pspat" | grep -v "grep")

    # extract tty of pane running process
    if [ -n "$test" ]; then
      mtty=$(echo "$test" | \grep -o "tty.[0-9]\{3\}")

      # find array index matching mtty
      i=0
      for k in ${panetty[@]}; do
        if [ "$k" == "$mtty" ]; then
          mind=$i
        fi
        let i+=1
      done

      # extract window and pane id's (window is current window)
      msid=${sessid[$mind]}
      mwid=${windowid[$mind]}
      mpid=${paneid[$mind]}

      # Output to stdout
      echo "$msid:$mwid.$mpid"
    fi
  fi

  return 0
}
#===============================================================================
#===============================================================================
