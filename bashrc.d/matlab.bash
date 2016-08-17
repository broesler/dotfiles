# Open MATLAB on my mac using bash readline!!
if [[ "$OSTYPE" == "darwin"* ]]; then
  function matlab()
  {
    # /Applications/MATLAB_R2015b.app/bin/matlab "$@"
    rlwrap -a dummy -c -m dummy \
      -H $HOME/.matlab/R2015b/history.m \
      /Applications/MATLAB_R2015b.app/bin/matlab -nosplash -nodesktop "$@"
  }
  export -f matlab
fi
