#~/.bash_profile
# vim:syntax=sh
#==============================================================================
#    File: ~/.bash_profile
# Created: 10/29/13
#  Author: Bernie Roesler
#
# Description: Loads for all login shells. Sets path variable and others
#==============================================================================

# Enable homebrew formulas to be used, as well as most recent git version
export PATH="/usr/local/git/bin:/usr/local/bin:$PATH"

#------------------------------------------------------------------------------
# Allow latex files to compile properly:
# Add texbin to path
export PATH="/usr/texbin:$PATH"

# Allow sort to produce expected behavior
export LC_ALL=C

# path to research folder
export RES=~/Documents/School/Research/

# path to latex style files
export STY=~/Library/texmf/tex/latex/

# Add Illustrator to Path
export PATH="/Applications/Adobe\ Illustrator\ CS6/:$PATH"

# Add XFOIL to path
export PATH="/Applications/Xfoil.app/Contents/Resources/:$PATH"

# tmux settings
export TERM='screen-256color'


#------------------------------------------------------------------------------
# If I have my own init file, then use that one, else use the
# canonical one.

if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi
#------------------------------------------------------------------------------

# Ruby setup:
eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/shims:$PATH"

#==============================================================================
