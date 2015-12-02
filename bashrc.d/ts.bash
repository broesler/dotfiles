# Shortcut for tmux send-keys to bottom-left
function ts()
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
export -f ts
