#!/bin/bash
# vim: ft=sh syntax=sh
#===============================================================================
#    File: ~/.bashrc.d/aliases.bash
# Created: 12/04/14
#  Author: Bernie Roesler
#
# Last Modified: 09/14/2016, 12:49
#
# Description: Contains aliases and simple functions for use with the bash shell
#===============================================================================

alias ep='vim ~/.bash_profile'               # edit profile (loaded with login)
alias erc='vim ~/.bashrc'                    # edit rc file (loaded with bash)
alias ea='vim ~/.bashrc.d/aliases.bash'      # edit aliases (loaded after rc)
alias rp='source ~/.bash_profile'            # reload profile
alias rrc='source ~/.bashrc'                 # reload JUST rc file (more common)

#-------------------------------------------------------------------------------
#       FOLDER AND APPLICATION SHORTCUTS
#-------------------------------------------------------------------------------
if [[ "$OSTYPE" == "darwin"* ]]; then
  alias cs174='cd ~/Documents/School/14F-15X/cs174_machine_learning/'
  alias es105='cd ~/Documents/School/13F-14X/Engs_105_Numerical_PDEs_1/hw/'
  alias es145='cd ~/Documents/School/13F-14X/Engs_145_Modern_Control_Theory/'
  alias es148='cd ~/Documents/School/14F-15X/engg148_structural_mechanics/'
  alias es150='cd ~/Documents/School/13F-14X/Engs_150/'
  alias illustrator='open -a Adobe\ Illustrator'
  alias res='cd ~/Documents/School/Research/'
  alias skim='open -a /Applications/Skim.app'
  alias sty='cd /Users/bernardroesler/Library/texmf/tex/latex/'
  alias web='cd ~/Documents/Projects/web_development/'
  alias xfoil='/Applications/Xfoil.app/Contents/Resources/xfoil'

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

  # Matlab with rlwrap (use vi commands in Matlab!)
  function matlabrl()
  {
    # $PATH includes: /Applications/MATLAB_R2015b.app/bin/
    rlwrap -a dummy -c -m dummy \
      -H $HOME/.matlab/R2015b/history.m \
      matlab -nosplash -nodesktop "$@"
  }

else    
  # we're on a Linux machine:
  alias flu1='/thayerfs/research/epps/VLM2D/Ramesh_FLUENT_cases/'
  alias fluent16='/thayerfs/research/epps/ansys_inc/v162/fluent/bin/fluent'
  alias nicefluent='nice -n19 /thayerfs/research/epps/ansys_inc/v162/fluent/bin/fluent 2ddp -t15 -g'
  alias gambit='/thayerfs/research/epps/Fluent.Inc/bin/gambit'
fi

# cs50 works on Mac and ThayerFS (Linux)
function cs50()
{
  if [ $# -gt 0 ]; then
      cd ~/Documents/School/cs50_software_design/labs/lab$1/
  else
      cd ~/Documents/School/cs50_software_design/
  fi
}

# cs60 works on Mac and ThayerFS (Linux)
function cs60()
{
  if [ $# -gt 0 ]; then
      cd ~/Documents/School/cs60_computer_networks/labs/lab$1/
  else
      cd ~/Documents/School/cs60_computer_networks/
  fi
}


#-------------------------------------------------------------------------------
#       UTILITIES
#-------------------------------------------------------------------------------
# Use a gold color for paths:
# alias myag="ag --color-path '1;49;38;5;136' --color-line-number '3;49;38;5;242' --color-match '1;49;38;5;9'"
# Color ag like grep:
# alias myag="ag --color-path '0;49;38;5;5' --color-line-number '3;49;38;5;242' --color-match '1;49;38;5;9'"
agcolors="  --color-path        '0;49;38;5;5'"
agcolors+=" --color-line-number '2;49;48'"
agcolors+=" --color-match       '1;49;38;5;9'"

# gfortran options
gfopts=' -cpp -Wall -pedantic -std=f95'
gfopts+=' -fbounds-check -ffree-line-length-0 -fbacktrace -fall-intrinsics'

alias myag="ag $agcolors"
alias clc='clear'
alias df='df -kTh'
alias du='du -kh'
alias grep='grep --color=auto'
alias h='history | command less +G'
alias j='jobs -l'
alias lpbw='lpr -P m210__bw___thayercups/duplex'
alias lpcolor='lpr -P m210__color___thayercups/duplex'
alias lt='tree -C'
alias mkdir='mkdir -p'
alias mlint='/Applications/MATLAB_R2015b.app/bin/maci64/mlint'
alias mygcc='gcc -Wall -pedantic -std=c99'
alias mygfortran="gfortran $gfopts"
alias path='echo $PATH | tr -s ":" "\n"'
alias which='type -all'
alias zgrep='zgrep --color=auto'

# Color list
[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
[ -e "$DIR_COLORS" ] || DIR_COLORS=""

# Set ls with colors
eval "$(dircolors -b ~/.dircolors)"    # set custom colors file
alias lc='ls -Ghlp --color=auto'      # Linux ls options

# Show hidden files only
alias lcd='lc -d .*'

# back up multiple directories
alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'

#===============================================================================
#===============================================================================
