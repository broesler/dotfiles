# Open xfoil on my mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  function xfoil()
  {
    /Applications/Xfoil.app/Contents/Resources/xfoil "$@"
  }
  export -f xfoil
fi
