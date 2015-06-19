#~/.bash_aliases
# vim: ft=sh syntax=sh
#==============================================================================
#    File: ~/.bash_aliases
# Created: 12/04/14
#  Author: Bernie Roesler
#
# Description: Contains aliases and simple functions for use with the bash shell
#==============================================================================

alias ep='vim -v ~/.bash_profile'    # edit profile (loaded with login)
alias erc='vim -v ~/.bashrc'         # edit rc file (loaded with bash)
alias ea='vim -v ~/.bash_aliases'    # edit aliases (loaded after rc)
alias rp='source ~/.bash_profile'   # reload profile
alias rrc='source ~/.bashrc'        # reload JUST rc file (more common)

#-------------------------------------------------------
#   FOLDER SHORTCUTS
#-------------------------------------------------------
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias cs174='cd ~/Documents/School/14F-15X/cs174_machine_learning/'
  alias es105='cd ~/Documents/School/13F-14X/Engs\ 105\ \-\ Numerical\ PDEs\ 1/Engs_105_practice/'
  alias es145='cd ~/Documents/School/13F-14X/Engs\ 145/'
  alias es148='cd ~/Documents/School/14F-15X/engg148_structural_mechanics/'
  alias es150='cd ~/Documents/School/13F-14X/Engs\ 150/'
  alias res='cd ~/Documents/School/Research/'
  alias sty='cd /Users/bernardroesler/Library/texmf/tex/latex/'
  alias web='cd ~/Documents/Projects/web_development/'
fi

cs50()
{
  if [ $# -gt 0 ]; then
      cd ~/Documents/School/cs50/labs/lab$1/
  else
      cd ~/Documents/School/cs50
  fi
}

es205()
{
  if [ $# -gt 0 ]; then
    cd ~/Documents/School/14F-15X/engs205_numerical_pdes_II/labs/lab$1
  else
    cd ~/Documents/School/14F-15X/engs205_numerical_pdes_II/labs
  fi
}

#-------------------------------------------------------
#   PROGRAM SHORTCUTS
#-------------------------------------------------------
alias matlab='/Applications/MATLAB_R2014b.app/bin/matlab'
alias xfoil='/Applications/Xfoil.app/Contents/Resources/xfoil'
alias skim='open -a /Applications/Skim.app'

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
  lpoptions -d m128_color___thayercups \
            -o Duplex=DuplexNoTumble \
            -o prettyprint
            -o cpi=14 \
            -o lpi=8 \
            -o page-top=18 \
            -o page-right=18 \
            -o page-bottom=36 \
            -o page-left=36
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
#   UTILITIES
#-------------------------------------------------------
alias clc='clear'
alias cp='cp -i'
alias df='df -kTh'
alias du='du -kh'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias gcc='gcc-5'
alias grep='grep --color=auto'
alias h='history'
alias j='jobs -l'
alias ldir="ls -l | grep '^d'"
alias lf="ls -l | grep -v '^d'"
alias lt='tree -C'
alias mkdir='mkdir -p'
alias mv='mv -i'
alias mygcc='gcc-5 -Wall -pedantic -std=c99'
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
if [[ "$OSTYPE" == "darwin"* ]]; then
  # # alias lc='ls -hopG'               # Mac OS X alias
  
  # If ~/.dircolors exists, set custom colors file
  [ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
  [ -e "$DIR_COLORS" ] || DIR_COLORS=""
  eval "`gdircolors -b ~/.dircolors`"   # set custom colors file

  alias lc='gls -Ghlp --color=auto'
  alias lcd='lc -d .*'

elif [[ "$OSTYPE" == "linux"* ]]; then
  # If ~/.dircolors exists, set custom colors file
  [ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
  [ -e "$DIR_COLORS" ] || DIR_COLORS=""
  eval "`dircolors -b ~/.dircolors`"    # set custom colors file

  alias lc='ls -Ghlp --color=auto'      # Linux ls options
  alias lcd='lc -d .*'
fi


# back up multiple directories
alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'



#-------------------------------------------------------
#   FUNCTIONS
#-------------------------------------------------------
# Homebrew update all things
brewup()
{
    brew update && brew prune && brew cleanup && brew upgrade --all 
}

# vim with server (only for LaTeX really)
vims()
{
  test=`command vim --version | grep -w clientserver`
  if [ "$test" ]; then
    if [ $# -eq 0 ]; then
      # No need to issue a remote command for no filename
      command vim --servername VIM
    else
      # Make compatible with Skim inverse-search command
      command vim --servername VIM --remote-silent ${@}
    fi
  else
    command vim $@ # ensure no server used
  fi
}

# Compile LaTeX WITHOUT bibliography
makepdf()
{
  texclean && pdflatex $1 && pdflatex $1 && open $1.pdf
}

# Compile LaTeX WITH bibliography
makepdfbib()
{
  texclean && pdflatex $1
  
  # make sure first attempt exited successfully
  if [ $? -eq 0 ]; then
    # run BiBTeX on each .bib file
    for i in `"ls" *.tex`
    do
      doc=$(echo $i | sed 's/\..*//')     # strip file extension
      bibtex $doc
    done

    # compile twice more and open the pdf output
    pdflatex $1 && pdflatex $1 && open $1.pdf
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
#==============================================================================
