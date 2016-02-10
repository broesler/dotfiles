# Remove all auxiliary files from tex directory
function texhtmlclean()
{
  rm -f *.4ct
  rm -f *.4tc
  rm -f *.css
  rm -f *.dvi
  rm -f *.html
  rm -f *.idv
  rm -f *.lg
  rm -f *.tmp
  rm -f *.xref
  rm -f *x.png
}
export -f texhtmlclean
