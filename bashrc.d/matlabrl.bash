# Open MATLAB on my mac using bash readline!!
if [[ "$OSTYPE" == "darwin"* ]]; then
  function matlabrl()
  {
    # /Applications/MATLAB_R2015b.app/bin/matlab "$@"
    rlwrap -a dummy -c -m dummy \
      -H $HOME/.matlab/R2015b/history.m \
      matlab -nosplash -nodesktop "$@"
  }
  export -f matlabrl
fi
