#!/bin/bash
# vim: ft=sh syntax=sh
#===============================================================================
#    File: ~/.bashrc.d/aliases.bash
# Created: 12/04/14
#  Author: Bernie Roesler
#
# Last Modified: 05/20/2016, 16:15
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
  alias es105='cd ~/Documents/School/13F-14X/Engs_105_Numerical_PDEs_1/hw/'
  alias es145='cd ~/Documents/School/13F-14X/Engs_145_Modern_Control_Theory/'
  alias es148='cd ~/Documents/School/14F-15X/engg148_structural_mechanics/'
  alias es150='cd ~/Documents/School/13F-14X/Engs_150/'
  alias res='cd ~/Documents/School/Research/'
  alias sty='cd /Users/bernardroesler/Library/texmf/tex/latex/'
  alias web='cd ~/Documents/Projects/web_development/'

  function es205()
  {
    if [ $# -gt 0 ]; then
      cd ~/Documents/School/14F-15X/engs205_numerical_pdes_II/labs/lab$1
    else
      cd ~/Documents/School/14F-15X/engs205_numerical_pdes_II/labs
    fi
  }

  function es149()
  {
    if [ $# -gt 0 ]; then
      cd ~/Documents/School/15F-16X/engg149_system_identification/hw/hw$1
    else
      cd ~/Documents/School/15F-16X/engg149_system_identification/hw
    fi
  }

  function es250()
  {
    if [ $# -gt 0 ]; then
      cd ~/Documents/School/15F-16X/engs250_turbulence/hw/hw$1
    else
      cd ~/Documents/School/15F-16X/engs250_turbulence/hw
    fi
  }

else
  alias flu1='/thayerfs/research/epps/VLM2D/Ramesh_FLUENT_cases/'
  alias fluent16='/thayerfs/research/epps/ansys_inc/v162/fluent/bin/fluent'
  alias nicefluent='nice -n19 /thayerfs/research/epps/ansys_inc/v162/fluent/bin/fluent 2ddp -t15 -g'
fi

# cs50 works on Mac and ThayerFS (Linux)
function cs50()
{
  if [ $# -gt 0 ]; then
      cd ~/Documents/School/cs50/labs/lab$1/
  else
      cd ~/Documents/School/cs50
  fi
}

#-------------------------------------------------------------------------------
#   UTILITIES
#-------------------------------------------------------------------------------
# Use a gold color for paths:
# alias myag="ag --color-path '1;49;38;5;136' --color-line-number '3;49;38;5;242' --color-match '1;49;38;5;9'"
# Color ag like grep:
# alias myag="ag --color-path '0;49;38;5;5' --color-line-number '3;49;38;5;242' --color-match '1;49;38;5;9'"
alias myag="ag --color-path '0;49;38;5;5' --color-line-number '2;49;48' --color-match '1;49;38;5;9'"
alias clc='clear'
alias df='df -kTh'
alias du='du -kh'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'
alias h='history | command less +G'
alias j='jobs -l'
alias lpbw='lpr -P m210__bw___thayercups/duplex'
alias lpcolor='lpr -P m210__color___thayercups/duplex'
alias lt='tree -C'
alias mkdir='mkdir -p'
alias mlint='/Applications/MATLAB_R2015b.app/bin/maci64/mlint'
alias mygcc='gcc -Wall -pedantic -std=c99'
alias path='echo $PATH | tr -s ":" "\n"'
alias which='type -all'
alias zegrep='zegrep --color=auto'
alias zfgrep='zfgrep --color=auto'
alias zgrep='zgrep --color=auto'

# Color list
[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
[ -e "$DIR_COLORS" ] || DIR_COLORS=""

# if [[ "$OSTYPE" == "darwin"* ]]; then
#   # alias lc='ls -hopG'               # Mac OS X alias
#   eval "$(gdircolors -b ~/.dircolors)"   # set custom colors file
#   alias lc='gls -Ghlp --color=auto'
#   alias ldir="gls -Ghlp --color=always | command grep '^d'"
#   alias lf="gls -Ghlp --color=always | command grep -v '^\(d\|total\)'"
#
# elif [[ "$OSTYPE" == "linux"* ]]; then
  # Only need these two lines with "brew install coreutils --with-default-names"
  eval "$(dircolors -b ~/.dircolors)"    # set custom colors file
  alias lc='ls -Ghlp --color=auto'      # Linux ls options
  # alias ldir="ls -Ghlp --color=always | command grep '^d'"
  # alias lf="ls -Ghlp --color=always | command grep -v '^\(d\|total\)'"
# fi

# Show hidden files only
alias lcd='lc -d .*'

# back up multiple directories
alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'

#===============================================================================
#===============================================================================
