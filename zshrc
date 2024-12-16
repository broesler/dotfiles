#~/.zshrc
#==============================================================================
#    File: ~/.zshrc
# Created: 2024-02-29 23:32
#  Author: Bernie Roesler
#
# Description: Contains aliases and settings for use with the zsh shell
#==============================================================================

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

case "$(hostname -s)" in
Bernard-MBP)
    # Enable git in the prompt
    autoload -Uz vcs_info
    precmd_vcs_info() { vcs_info }
    precmd_functions+=( precmd_vcs_info )
    setopt PROMPT_SUBST
    RPS1='${vcs_info_msg_0_}'
    zstyle ':vcs_info:git:*' formats '%F{purple}%a%f (%b)%m%u%c'
    zstyle ':vcs_info:*' enable git

    # Set the prompt with bold green text
    PS1="%B%F{green}%1~ %# %f%b"

    # Ruby initialization
    source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
    source /opt/homebrew/opt/chruby/share/chruby/auto.sh
    chruby ruby-3.1.3
    ;;
*)
    # default no color
    PS1="%n@%m %1~ %# "
    ;;
esac

# If in ssh session, change the prompt
if [[ -n "$SSH_CLIENT" ]]; then
    echo "Welcome to $(scutil --get ComputerName) ($(sw_vers --productVersion))"
    PS1="%B%F{cyan}[%n@%m %3~] %# %f%b"
fi

HISTFILE=${ZDOTDIR:-$HOME}/.zsh_history
SAVEHIST=$((1 << 12))  # 4096 lines in memory
HISTSIZE=$((1 << 24))  # 16e6 lines in file

setopt EXTENDED_HISTORY    # include timestamp and elapsed time
setopt INC_APPEND_HISTORY  # append to history as commandas are entered
setopt SHARE_HISTORY       # share history across multiple sessions
setopt HIST_IGNORE_DUPS    # do not save lines if they are duplicates
setopt HIST_IGNORE_SPACE   # remove command from history with leading space
setopt HIST_VERIFY         # do not execute immediately upon history expansion

setopt AUTO_CD        # don't need `cd` before a path, replaces '..' alias.
setopt AUTO_PUSHD     # keep all directories on the stack for each changing
setopt PUSHD_IGNORE_DUPS

setopt ALIASES        # expand aliases (needed for vim :!)
setopt CHECK_JOBS     # displays stopped or running job status before exiting
setopt CORRECT        # try to correct all options
setopt EXTENDED_GLOB  # extend glob to regexes ^,#,~

# Completion
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' menu select
zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages' format ' %F{purple} -- %d --%f'

# Use hjkl to navigate the completion list
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# Load this AFTER all of the completions
autoload -Uz compinit && compinit

# Color list
[ -e "$HOME/.dircolors" ] && DIR_COLORS="$HOME/.dircolors"
[ -e "$DIR_COLORS" ] || DIR_COLORS=""

# Set ls with colors
eval "$(dircolors -b $DIR_COLORS)"
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# less highlighting for man pages:
# NOTE: do not actually use "tput bold" because iTerm uses "bright" colors,
# which in Solarized scheme are just grayscale other than red
export LESS_TERMCAP_mb=$(tput setaf 2)                # start blink
export LESS_TERMCAP_md=$(tput setaf 3)                # start bold
export LESS_TERMCAP_me=$(tput sgr0)                   # end bold/blink
export LESS_TERMCAP_us=$(tput smul; tput setaf 4)     # start underline
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)        # end underline
export LESS_TERMCAP_so=$(tput setaf 0; tput setab 3)  # start highlight
export LESS_TERMCAP_se=$(tput sgr0)                   # end highlight

# Anaconda include
# TODO set variable with the name of the environment?
conda activate dev311 2> /dev/null

# ----------------------------------------------------------------------------- 
#         Aliases
# -----------------------------------------------------------------------------
alias ep='vim ~/.zprofile'     # edit profile (loaded with login)
alias erc='vim ~/.zshrc'       # edit rc file (loaded with bash)
alias rp='source ~/.zprofile'  # reload profile
alias rrc='source ~/.zshrc'    # reload profile

# gfortran options
gfopts=' -cpp -Wall -pedantic -std=f95'
gfopts+=' -fbounds-check -ffree-line-length-0 -fbacktrace -fall-intrinsics'

alias df='df -kTh'
alias diff='diff --color=auto'
alias du='du -kh'
alias grep='grep --color=auto'
alias h='history | command less +G'
alias j='jobs -l'
alias lc='ls -Ghlp --color=auto'  # gnu-ls options
alias lcd='lc -d .*'              # Show hidden files only
alias lt='tree -C'
alias mkdir='mkdir -p'
alias mygcc='gcc-14 -Wall -pedantic -std=c99'
alias myg++='g++-14 -Wall -pedantic -std=c++20'
alias myclang++='clang++ -Wall -pedantic -std=c++20'
alias mygfortran="gfortran $gfopts"
alias showpath='echo $PATH | tr -s ":" "\n"'
alias showfpath='echo $FPATH | tr -s ":" "\n"'
# alias sicp='rlwrap -r -c -f "$HOME"/src/scheme/mit_scheme_bindings.txt scheme'
alias sicp='mechanics.sh'
alias ta='type -a'

# back up multiple directories
alias ..='cd ..'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'

# Enable fzf completions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ----------------------------------------------------------------------------- 
#         Key bindings
# -----------------------------------------------------------------------------
# Enable vim-style editing in terminal (also see ~/.inputrc)
export EDITOR=vim
bindkey -v

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd '^v' edit-command-line

bindkey -M viins '^n' history-beginning-search-backward
bindkey -M viins '^p' history-beginning-search-forward

bindkey -M vicmd 'k' history-beginning-search-backward
bindkey -M vicmd 'j' history-beginning-search-forward

bindkey -M vicmd '/' history-incremental-search-backward
bindkey -M vicmd '?' history-incremental-search-forward

#==============================================================================
#==============================================================================
