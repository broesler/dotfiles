# Open Matlab on my mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  function matlab()
  {
    /Applications/MATLAB_R2015b.app/bin/matlab "$@"
  }
  export -f matlab
fi
