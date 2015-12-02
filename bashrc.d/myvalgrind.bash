# Standard valgrind options
function myvalgrind() 
{ 
  options='--leak-check=full --show-leak-kinds=all --track-origins=yes'
  options+='--dsymutil=yes --log-file=valout'

  command valgrind "$options" -v "$@"
}
export -f myvalgrind
