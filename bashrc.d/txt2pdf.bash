# convert text file to pdf
txt2pdf()
{
  enscript $1 -p temp.ps    # convert to postscript
  ps2pdf temp.ps $1.pdf     # convert to pdf
  rm -f temp.ps
}
