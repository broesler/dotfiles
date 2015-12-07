# Shortcut for tmux send-keys to bottom-left
function ts()
{
  if [ -n "$TMUX" ]; then
    if [ "$1" == "-t" ]; then
      target=$2
      args=${@:3}
    else
      target="bottom-left"
      args=$@
    fi

    # Execute command literally, then send carriage return
    tmux send-keys -t "$target" -l "$args"
    tmux send-keys -t "$target" C-m

  else
    echo "Usage: tmux must be running to use send-keys!" 1>&2
    return 1
  fi

  return 0
}
export -f ts
