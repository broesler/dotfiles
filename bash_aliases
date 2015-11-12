#~/.bash_aliases
# vim: ft=sh syntax=sh
#===============================================================================
#    File: ~/.bash_aliases
# Created: 12/04/14
#  Author: Bernie Roesler
#
# Description: Contains aliases and simple functions for use with the bash shell
#===============================================================================

alias ep='vim ~/.bash_profile'      # edit profile (loaded with login)
alias erc='vim ~/.bashrc'           # edit rc file (loaded with bash)
alias ea='vim ~/.bash_aliases'      # edit aliases (loaded after rc)
alias rp='source ~/.bash_profile'   # reload profile
alias rrc='source ~/.bashrc'        # reload JUST rc file (more common)

#-------------------------------------------------------------------------------
#   FOLDER SHORTCUTS
#-------------------------------------------------------------------------------
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias cs174='cd ~/Documents/School/14F-15X/cs174_machine_learning/'
  alias es105='cd ~/Documents/School/13F-14X/Engs\ 105\ \-\ Numerical\ PDEs\ 1/Engs_105_practice/'
  alias es145='cd ~/Documents/School/13F-14X/Engs\ 145\ \-\ Modern\ Control\ Theory/'
  alias es148='cd ~/Documents/School/14F-15X/engg148_structural_mechanics/'
  alias es150='cd ~/Documents/School/13F-14X/Engs\ 150/'
  alias res='cd ~/Documents/School/Research/'
  alias sty='cd /Users/bernardroesler/Library/texmf/tex/latex/'
  alias web='cd ~/Documents/Projects/web_development/'

  es205()
  {
    if [ $# -gt 0 ]; then
      cd ~/Documents/School/14F-15X/engs205_numerical_pdes_II/labs/lab$1
    else
      cd ~/Documents/School/14F-15X/engs205_numerical_pdes_II/labs
    fi
  }

  es250()
  {
    if [ $# -gt 0 ]; then
      cd ~/Documents/School/15F-16X/engs250_turbulence/hw/hw$1
    else
      cd ~/Documents/School/15F-16X/engs250_turbulence/hw
    fi
  }
else
  alias gambit='/thayerfs/research/epps/Fluent.Inc/bin/gambit'
fi

# cs50 works on Mac and Linux
cs50()
{
  if [ $# -gt 0 ]; then
      cd ~/Documents/School/cs50/labs/lab$1/
  else
      cd ~/Documents/School/cs50
  fi
}

#-------------------------------------------------------------------------------
#   PROGRAM SHORTCUTS
#-------------------------------------------------------------------------------
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias matlab='/Applications/MATLAB_R2015b.app/bin/matlab'
  alias xfoil='/Applications/Xfoil.app/Contents/Resources/xfoil'
  alias skim='open -a /Applications/Skim.app'
fi

#-------------------------------------------------------------------------------
#   UTILITIES
#-------------------------------------------------------------------------------
alias clc='clear'
alias cp='cp -i'
alias df='df -kTh'
alias du='du -kh'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias h='history'
alias j='jobs -l'
alias ldir="ls -l | grep '^d'"
alias lf="ls -l | grep -v '^d'"
alias lt='tree -C'
alias mkdir='mkdir -p'
alias mv='mv -i'
alias mygcc='gcc -Wall -pedantic -std=c99'
alias mygfortran='gfortran-5 -cpp -Wall -pedantic -std=f95 \
                    -fbounds-check -ffree-line-length-0 -fbacktrace \
                    -fall-intrinsics'
alias r='rlogin'
alias rm='rm -i'
alias which='type -all'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
alias zgrep='zgrep --color=auto'

# alias myvalgrind='valgrind --leak-check=full --show-leak-kinds=all 
#                  '--track-origins=yes --dsymutil=yes --log-file=valout -v'


# Color list
[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
[ -e "$DIR_COLORS" ] || DIR_COLORS=""

if [[ "$OSTYPE" == "darwin"* ]]; then
  # # alias lc='ls -hopG'               # Mac OS X alias
  eval "$(gdircolors -b ~/.dircolors)"   # set custom colors file
  alias lc='gls -Ghlp --color=auto'

elif [[ "$OSTYPE" == "linux"* ]]; then
  eval "$(dircolors -b ~/.dircolors)"    # set custom colors file
  alias lc='ls -Ghlp --color=auto'      # Linux ls options
fi

# Show hidden files only
alias lcd='lc -d .*'

# back up multiple directories
alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'



#-------------------------------------------------------------------------------
#   FUNCTIONS
#-------------------------------------------------------------------------------
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
  lpoptions -d m210__color___thayercups \
            -o Duplex=DuplexNoTumble \
            -o prettyprint
            -o cpi=14 \
            -o lpi=8 \
            -o page-top=18 \
            -o page-right=18 \
            -o page-bottom=36 \
            -o page-left=36
  lpr -P m210__color___thayercups $1
}

# convert text file to pdf
txt2pdf()
{
  enscript $1 -p temp.ps    # convert to postscript
  ps2pdf temp.ps $1.pdf     # convert to pdf
  rm -f temp.ps
}

# Homebrew update all the things
brewup()
{
  brew update           # update homebrew formulas
  brew upgrade --all    # upgrade programs installed via homebrew
  brew prune            # remove old versions of programs
  brew cleanup          # remove old formulas
}

# vim with server (only for LaTeX + Skim really)
vims()
{
  test=$(command vim --version | grep -w clientserver)
  if [ "$test" ]; then
    if [ $# -eq 0 ]; then
      # No need to issue a remote command for no filename
      command vim --servername VIM
    else
      # Make compatible with Skim inverse-search command
      command vim --servername VIM --remote-silent ${@}
    fi
  else
    command vim $@      # ensure no server used
  fi
}

#-------------------------------------------------------------------------------
# The following functions work fine for compiling LaTeX documents the simplest,
# most straightforward way; however, I now use command 'latexmk' with associated
# ~/.latexmkrc file, which intelligently rebuilds the appropriate number of
# times, with/without bibliography, depending on which files have been changed.
#-------------------------------------------------------------------------------
# Compile LaTeX WITHOUT bibliography
makepdf()
{
  # include synctex zipped file for linking to pdf file
  pdfcommand='pdflatex -synctex=1 -interaction=nonstopmode -file-line-error'
  texclean && $pdfcommand $1 && $pdfcommand $1 && open $1.pdf
}

# Compile LaTeX WITH bibliography
makepdfbib()
{
  # include synctex zipped file for linking to pdf file
  pdfcommand='pdflatex -synctex=1 -interaction=nonstopmode -file-line-error'

  # remove aux files and compile
  texclean && $pdfcommand $1
  
  # make sure first attempt exited successfully
  if [ $? -eq 0 ]; then
    # run BiBTeX on each .bib file
    for i in $("ls" *.tex)
    do
      doc=$(echo $i | sed 's/\..*//')     # strip file extension
      bibtex $doc
    done

    # compile twice more and open the pdf output
    $pdfcommand $1 && $pdfcommand $1 && open $1.pdf
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
  rm -f *.fls
  rm -f *.fdb_latexmk
  rm -f *.synctex*.gz
}

#===============================================================================
#===============================================================================
