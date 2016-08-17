# Make directory and change into it
function mcdir ()
{
  if [ "$#" -eq 0 ]; then
    echo "Usage: mcdir requires an argument" 2>&1
    return 1;
  fi
  command mkdir -p "$@" && command cd "$_"
}
export -f mcdir
