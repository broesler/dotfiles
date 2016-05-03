# Shortcut for tmux send-keys to bottom-left
function ts()
{
  if [ -z "$TMUX" ]; then
    echo "Usage: tmux must be running to use send-keys!" 1>&2
    return 1
  fi

  # Declare local variables
  local OPTIND opt args
  local target="bottom-left"

  while getopts ":t:" opt; do
    case $opt in
      t)
        target="$OPTARG"
        ;;
      \?)
        echo "Invalid option: -$OPTARG" >&2
        return 1
        ;;
      :)
        echo "Usage: ts -$OPTARG [pane]." >&2
        return 1
        ;;
    esac
  done

  # shift the arguments to skip over the options to the real arguments (NOT
  # including those assigned by $OPTARG above)
  shift $((OPTIND-1))     
  args="$@"

  # Execute command literally, then send carriage return
  tmux send-keys -t "$target" -l "$args" && \
  tmux send-keys -t "$target" C-m

  return 0
}
export -f ts
