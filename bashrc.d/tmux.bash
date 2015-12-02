# Attach to existing tmux session rather than create a new one if possible
function tmux() 
{
  # Force tmux to use 256 colors with -2 option (get solarized right)
  # If given any arguments, just use them as they are
  if (($#)) ; then
    command tmux -2 "$@"

  # If a session exists, just attach to it
  elif command tmux has-session 2>/dev/null ; then
    command tmux -2 attach-session -d

  # Create a new session with an appropriate name
  else
    command tmux -2 new-session -s "${TMUX_SESSION:-default}"
  fi
}
export -f tmux
