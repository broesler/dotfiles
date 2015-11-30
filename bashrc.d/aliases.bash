#~/.bash_aliases
# vim: ft=sh syntax=sh
#===============================================================================
#    File: ~/.bash_aliases
# Created: 12/04/14
#  Author: Bernie Roesler
#
# Description: Contains aliases and simple functions for use with the bash shell
#===============================================================================

alias ep='vim ~/.bash_profile'               # edit profile (loaded with login)
alias erc='vim ~/.bashrc'                    # edit rc file (loaded with bash)
alias ea='vim ~/.bashrc.d/aliases.bash'      # edit aliases (loaded after rc)
alias rp='source ~/.bash_profile'            # reload profile
alias rrc='source ~/.bashrc'                 # reload JUST rc file (more common)

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
  alias illustrator='open -a Adobe\ Illustrator'
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
alias rm='rm -i'
# alias which='type -all'
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

#===============================================================================
#===============================================================================