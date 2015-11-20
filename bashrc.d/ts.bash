# shortcut for tmux send-keys to bottom-left
ts()
{
  tmux send-keys -t bottom-left "$@" C-m
}
