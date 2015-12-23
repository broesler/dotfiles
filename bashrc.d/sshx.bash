# ssh to babylon x
function sshx() 
{
  # Check if we're already in ssh session
  if [ -z "$SSH_TTY" ]; then
    # Check if we're in tmux or not
    if [ -z "$TMUX" ]; then
      # connecting from plain terminal
      command ssh -X d26725q@babylon$1.thayer.dartmouth.edu
    else
      # connecting through tmux
      # command ssh -X -t d26725q@babylon$1.thayer.dartmouth.edu bash --rcfile '~/.bashrc.tmux'
      command ssh -X d26725q@babylon$1.thayer.dartmouth.edu
    fi
  else
    read -p "Warning: Aready in SSH session. Ok to nest? [yn] >" > choice
    case $choice in
      y)
        # Check if we're in tmux or not
        if [ -z "$TMUX" ]; then
          # connecting from plain terminal
          command ssh -X d26725q@babylon$1.thayer.dartmouth.edu
        else
          # connecting through tmux
          # command ssh -X -t d26725q@babylon$1.thayer.dartmouth.edu bash --rcfile '~/.bashrc.tmux'
          command ssh -X d26725q@babylon$1.thayer.dartmouth.edu
        fi
        ;;
      *)
        return 0
    esac
  fi
}
export -f sshx
