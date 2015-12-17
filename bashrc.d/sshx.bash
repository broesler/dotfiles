# ssh to babylon x
function sshx() 
{
  if [ -n "$SSH_TTY" ]; then
    read -p "Warning: Aready in SSH session. Ok to nest? [yn] >" > choice
    case $choice in
      y)
        # Check if we're in tmux or not
        if [ -z "$TMUX" ]; then
          # connecting from plain terminal
          command ssh -X d26725q@babylon$1.thayer.dartmouth.edu
        else
          # connecting through tmux
          command ssh -X -t d26725q@babylon$1.thayer.dartmouth.edu bash --rcfile '~/.bashrc.tmux'
        fi
        ;;
      *)
        return 0
    esac
  else
    # Check if we're in tmux or not
    if [ -z "$TMUX" ]; then
      # connecting from plain terminal
      command ssh -X d26725q@babylon$1.thayer.dartmouth.edu
    else
      # connecting through tmux
      command ssh -X -t d26725q@babylon$1.thayer.dartmouth.edu bash --rcfile '~/.bashrc.tmux'
    fi
  fi
}
export -f sshx
