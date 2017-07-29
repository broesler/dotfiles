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
    alias cs174='cd ~/Documents/School/14F-15X/cs174_machine_learning/'
    alias mycv='cd ~/Documents/School/CV_Resume/CV/cv_latex/'
    alias myresume='cd ~/Documents/School/CV_Resume/Resume/resume_latex/'
    alias es91='cd ~/Documents/School/11F-12S/Engs_91/labs/'
    alias es105='cd ~/Documents/School/13F-14X/Engs_105_Numerical_PDEs_1/hw/'
    alias es145='cd ~/Documents/School/13F-14X/Engs_145_Modern_Control_Theory/'
    alias es148='cd ~/Documents/School/14F-15X/engg148_structural_mechanics/'
    alias es150='cd ~/Documents/School/13F-14X/Engs_150/'
    alias illustrator='open -a Adobe\ Illustrator'
    alias res='cd ~/Documents/School/Research/'
    # alias skim='open -a /Applications/Skim.app'
    alias sty='cd /Users/bernardroesler/Library/texmf/tex/latex/'
    alias web='cd ~/Documents/Projects/web_development/'
    alias xfoil='/Applications/Xfoil.app/Contents/Resources/xfoil'
    alias cyrod='~/Kite_Drive/2016_ORPC_drone_turbine_\(Roesler\)/Codes/CyROD_2D_Lumped/Examples/ORPC_RPD_rapid_prototype_device/'

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
        # $PATH includes: /Applications/MATLAB_R2016b.app/bin/
        rlwrap -a dummy -c -m dummy \
            -H $HOME/.matlab/R2016b/history.m \
            matlab -nosplash -nodesktop "$@"
    }
    ;;

babylon*) # we're on a Linux machine:
    alias flu1='/thayerfs/research/epps/VLM2D/Ramesh_FLUENT_cases/'
    alias fluent16='/thayerfs/research/epps/ansys_inc/v162/fluent/bin/fluent'
    # alias fluent16='/jumbo/eppsdata/ansys_inc/v162/fluent/bin/fluent'
    alias gambit='/thayerfs/research/epps/Fluent.Inc/bin/gambit'
    # alias gambit='/jumbo/eppsdata/Fluent.Inc/bin/gambit'
    ;;
esac

# cs[56]0 work on Mac and ThayerFS (Linux)
function cs50()
{
    if [ $# -gt 0 ]; then
        cd ~/Documents/School/cs50_software_design/labs/lab$1/
    else
        cd ~/Documents/School/cs50_software_design/
    fi
}

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

# Color ag like grep:
agcolors="  --color-path        '0;49;38;5;5'"
agcolors+=" --color-line-number '0;49;32'"
agcolors+=" --color-match       '1;49;38;5;9'"

# gfortran options
gfopts=' -cpp -Wall -pedantic -std=f95'
gfopts+=' -fbounds-check -ffree-line-length-0 -fbacktrace -fall-intrinsics'

alias clc='clear'
alias df='df -kTh'
alias du='du -kh'
alias edwin='mit-scheme --edit --heap 100000'
alias grep='grep --color=auto'
alias h='history | command less +G'
alias j='jobs -l'
alias lpbw='lpr -P m210__bw___thayercups/duplex'
alias lpcolor='lpr -P m210__color___thayercups/duplex'
alias lt='tree -C'
alias mkdir='mkdir -p'
alias mlint='/Applications/MATLAB_R2016b.app/bin/maci64/mlint'
alias myag="ag $agcolors"
alias mygcc='gcc -Wall -pedantic -std=c99'
alias mygfortran="gfortran $gfopts"
alias path='echo $PATH | tr -s ":" "\n"'
alias sicp='rlwrap -r -c -f "$HOME"/src/scheme/mit_scheme_bindings.txt scheme'
alias which='type -all'
alias zgrep='zgrep --color=auto'

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

#===============================================================================
#===============================================================================
# vim: ft=sh syntax=sh
