# Remove all auxiliary files from tex directory
function texclean()
{
  rm -f *.aux
  rm -f *.bbl
  rm -f *.blg
  rm -f *.log
  rm -f *.out
  rm -f *.toc
  rm -f *.fls
  rm -f *.fdb_latexmk
  rm -f *.synctex*.gz
}
export -f texclean
