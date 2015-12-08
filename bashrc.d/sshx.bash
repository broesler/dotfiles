# ssh to babylon x
function sshx() 
{
  if [ -n "$SSH_TTY" ]; then
    read -p "Warning: Aready in SSH session. Ok to nest? [yn] >" > choice
    case $choice in
      y)
        ssh -X d26725q@babylon$1.thayer.dartmouth.edu
        ;;
      *)
        return 0
    esac
  else
    ssh -X d26725q@babylon$1.thayer.dartmouth.edu
  fi
}
export -f sshx
