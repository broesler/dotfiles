#!/bin/bash
#===============================================================================
#     File: ~/.bashrc.d/aliases.bash
#  Created: 12/04/14
#   Author: Bernie Roesler
# 
#  Last Modified: 09/14/2016, 12:49
# 
#  Description: Contains aliases and simple functions for use with the bash
#       shell. This file is only loaded with ~/.bashrc for interactive shells.
# 
#===============================================================================

alias ep='vim ~/.bash_profile'               # edit profile (loaded with login)
alias erc='vim ~/.bashrc'                    # edit rc file (loaded with bash)
alias ea='vim ~/.bashrc.d/aliases.bash'      # edit aliases (loaded after rc)
alias rp='source ~/.bash_profile'            # reload profile
alias rrc='source ~/.bashrc'                 # reload JUST rc file (more common)

#-------------------------------------------------------------------------------
#       FOLDER AND APPLICATION SHORTCUTS
#-------------------------------------------------------------------------------
host=$(hostname -s) # i.e. 't1854', 'babylon', 'polaris'

case "$host" in
t1854)  # my MBP
    # Quick directories
    alias cs174='cd ~/Documents/School/14F-15X/cs174_machine_learning/'
    alias es105='cd ~/Documents/School/13F-14X/Engs_105_Numerical_PDEs_1/hw/'
    alias es145='cd ~/Documents/School/13F-14X/Engs_145_Modern_Control_Theory/'
    alias es145='cd ~/Documents/School/15F-16X/engg149_system_identification/hw/'
    alias es148='cd ~/Documents/School/14F-15X/engg148_structural_mechanics/'
    alias es150='cd ~/Documents/School/13F-14X/Engs_150/'
    alias es205='cd ~/Documents/School/14F-15X/engs205_numerical_pdes_II/labs/'
    alias es91='cd ~/Documents/School/11F-12S/Engs_91/labs/'
    alias mycv='cd ~/Documents/CV_Resume/CV/cv_latex/'
    alias myresume='cd ~/Documents/CV_Resume/Resume/resume_latex/'
    alias sty='cd /Users/bernardroesler/Library/texmf/tex/latex/'

    # Apps
    alias mlint='/Applications/MATLAB_R2018a.app/bin/maci64/mlint'
    alias xfoil='/Applications/Xfoil.app/Contents/Resources/xfoil'

    # Matlab with rlwrap (use vi commands in Matlab!)
    function matlabrl()
    {
        # $PATH includes: /Applications/MATLAB_R2016b.app/bin/
        rlwrap -a dummy -c -m dummy \
            -H $HOME/.matlab/R2018a/history.m \
            matlab -nosplash -nodesktop "$@"
    }
    ;;

# Add case for work PC here...
esac

# cs[56]0 work on Mac and ThayerFS (Linux)
function cs50()
{
    base="$HOME/Documents/School/cs50_software_design"
    if [ $# -gt 0 ]; then
        cd "$base/labs/lab$1/"
    else
        cd "$base"
    fi
}

function cs60()
{
    base="$HOME/Documents/School/cs60_computer_networks"
    if [ $# -gt 0 ]; then
        cd "$base/labs/lab$1/"
    else
        cd "$base"
    fi
}

#-------------------------------------------------------------------------------
#       UTILITIES
#-------------------------------------------------------------------------------
# Color ag like grep:
agcolors=" --color-path '0;49;38;5;5'"
agcolors+=" --color-line-number '0;49;32'"
agcolors+=" --color-match '1;49;38;5;9'"

# gfortran options
gfopts=' -cpp -Wall -pedantic -std=f95'
gfopts+=' -fbounds-check -ffree-line-length-0 -fbacktrace -fall-intrinsics'

alias clc='clear'
alias df='df -kTh'
alias du='du -kh'
alias grep='grep --color=auto'
alias h='history | command less +G'
alias j='jobs -l'
alias lt='tree -C'
alias mkdir='mkdir -p'
alias myag="ag $agcolors"
alias mygcc='gcc-8 -Wall -pedantic -std=c99'
alias mygfortran="gfortran $gfopts"
alias show_path='echo $PATH | tr -s ":" "\n"'
alias sicp='rlwrap -r -c -f "$HOME"/src/scheme/mit_scheme_bindings.txt scheme'
alias ta='type -a'

# Color list
[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
[ -e "$DIR_COLORS" ] || DIR_COLORS=""

# Set ls with colors
eval "$(dircolors -b ~/.dircolors)"     # set custom colors file
alias lc='ls -Ghlp --color=auto'        # Linux ls options

# Show hidden files only
alias lcd='lc -d .*'

# back up multiple directories
alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'

#------------------------------------------------------------------------------- 
#        Notes
#-------------------------------------------------------------------------------
# Colors:   
    #   attribute = single digit
    #       1 = bold
    #       2 = dim
    #       3 = italics? 
    #       4 = underline
    #       5 = blink
    #       7 = invert fg/bg
    #       9 = hidden (i.e. for passwords) 
    #   foreground = 3? normal,  9? bright
    #   background = 4? normal, 10? bright
    #       9 = default
    #       0 = black
    #       1 = red
    #       2 = green
    #       3 = yellow
    #       4 = blue
    #       5 = magenta
    #       6 = cyan
    #       7 = light grey
    #       8;5;[0-256] = 256 ANSI colors, i.e. '38;5;[0-256]'

#===============================================================================
#===============================================================================
# vim: ft=sh syntax=sh
