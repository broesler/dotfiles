# Use skim on my Mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  function skim()
  {
    open -a /Applications/Skim.app "$@"
  }
  export -f skim
fi
