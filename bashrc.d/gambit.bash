# Use gambit on Linux machines
if [[ "$OSTYPE" != "darwin"* ]]; then
  function gambit()
  {
    /thayerfs/research/epps/Fluent.Inc/bin/gambit
  }
  export -f gambit
fi

