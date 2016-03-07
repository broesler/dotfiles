# Make directory and change into it
function mcd ()
{
  if [ "$#" -eq 0 ]; then
    echo "Usage: mcd requires an argument" 2>&1
    return 1;
  fi
  command mkdir -p "$@" && command cd "$_"
}
export -f mcd
