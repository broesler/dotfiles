#~/.bash_aliases
# vim:syntax=sh
#==============================================================================
#    File: ~/.bash_aliases
# Created: 12/04/14
#  Author: Bernie Roesler
#
# Description: Contains aliases and simple functions for use with the bash shell
#==============================================================================

alias ep='vim ~/.bash_profile'      # edit profile
alias erc='vim ~/.bashrc'
alias ea='vim ~/.bash_aliases'      # edit aliases
alias rp='source ~/.bash_profile'   # reload profile
alias rrc='source ~/.bashrc'        # reload JUST rc file (more common)
alias vimrc='vim ~/.vimrc'           # edit vim profile

#-------------------------------------------------------
#   FOLDER SHORTCUTS
#-------------------------------------------------------

if [[ "$OSTYPE" == "darwin"* ]]; then
  alias cs174='cd ~/Documents/School/14F-15X/cs174_machine_learning/'
  alias es105='cd ~/Documents/School/13F-14X/Engs\ 105/Engs_105_practice/'
  alias es145='cd ~/Documents/School/13F-14X/Engs\ 145/'
  alias es148='cd ~/Documents/School/14F-15X/engg148_structural_mechanics/'
  alias es150='cd ~/Documents/School/13F-14X/Engs\ 150/'
  alias res='cd ~/Documents/School/Research/'
  alias sty='cd /Users/bernardroesler/Library/texmf/tex/latex/'
  alias web='cd ~/Documents/Projects/web_development/'
fi

# go to CS 50 lab #
cs50()
{
  if [ $# -gt 0 ]
  then
      cd ~/Documents/School/cs50/labs/lab$1/
  else
      cd ~/Documents/School/cs50
  fi
}

#-------------------------------------------------------
#   PROGRAM SHORTCUTS
#-------------------------------------------------------
# MATLAB alias
alias matlab='/Applications/MATLAB_R2014b.app/bin/matlab'

# add XFOIL to path
alias xfoil='open -a xfoil'

# ssh to babylon x
sshx() 
{
    ssh -X d26725q@babylon$1.thayer.dartmouth.edu
}

# illustrator
alias illustrator='open -a Adobe\ Illustrator'

# color printing
lpcolor()
{
  lpoptions -d m128_color___thayercups -o Duplex=DuplexNoTumble -o prettyprint
  lpr -P m128_color___thayercups $1
}

# convert text file to pdf
txt2pdf()
{
  enscript $1 -p temp.ps    # convert to postscript
  ps2pdf temp.ps $1.pdf     # convert to pdf
  rm -f temp.ps
}


#-------------------------------------------------------
#   FUNCTIONS
#-------------------------------------------------------

# Compile LaTeX WITHOUT bibliography
makepdf()
{
  texclean
  pdflatex $1

  # make sure first attempt exited successfully
  if [ $? -eq 0 ]; then
    pdflatex $1
    open $1.pdf
  else
    return 1
  fi
}

# Compile LaTeX WITH bibliography
makepdfbib()
{
  texclean
  pdflatex $1
  
  # make sure first attempt exited successfully
  if [ $? -eq 0 ]; then
    # run BiBTeX
    for i in `ls *.tex`
    do
      doc=$(echo $i | sed 's/\..*//')     # strip file extension
      bibtex $doc
    done

    pdflatex $1
    pdflatex $1
    open $1.pdf
  else  # there are errors in the tex, exit
    return 1
  fi
}

# Remove all auxiliary files from tex directory
texclean()
{
  rm -f *.aux
  rm -f *.bbl
  rm -f *.blg
  rm -f *.log
  rm -f *.out
  rm -f *.toc
}

#-------------------------------------------------------
#   UTILITIES
#-------------------------------------------------------
alias clc='clear'
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias zgrep='zgrep --color=auto'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
# alias myvalgrind='valgrind --leak-check=full --show-leak-kinds=all 
#                  '--track-origins=yes --dsymutil=yes --log-file=valout -v'

# Lifesavers
alias cp='cp -i'
alias df='df -kTh'
alias du='du -kh'
alias h='history'
alias j='jobs -l'
alias ldir="ls -l | grep '^d'"
alias lf="ls -l | grep -v '^d'"
alias mkdir='mkdir -p'
alias mv='mv -i'
alias mygcc='gcc -Wall -pedantic -std=c99'
alias mygfortran='gfortran -Wall -pedantic -std=f95 -fbounds-check -ffree-line-length-0'
alias r='rlogin'
alias rm='rm -i'
alias vi='vim'
alias :e='vim'
alias which='type -all'

# Color list
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias lc='ls -Ghlp'
elif [[ "$OSTYPE" == "linux"* ]]; then
  alias lc='ls -Ghlp --color=auto' # Linux ls options
fi

alias lt='tree -C'

# back up multiple directories
alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'

#==============================================================================
