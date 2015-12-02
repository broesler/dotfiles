# Use Adobe Illustrator on my Mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  function illustrator()
  {
    open -a Adobe\ Illustrator
  }
  export -f illustrator
fi
