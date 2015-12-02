# ssh to babylon x
function sshx() 
{
    ssh -X d26725q@babylon$1.thayer.dartmouth.edu
}
export -f sshx
