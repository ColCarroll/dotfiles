#!/bin/bash

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check machine OS
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
    *)          machine=Unknown;;
esac

if [ "${machine}" = Unknown ]; then
    echo Unknown operating system\n"${unameOut}"\nExiting
    exit 1
fi

# git completion, and other bash completion
if [ "${machine}" = Mac ]; then
	if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
		. "$(brew --prefix)/etc/bash_completion"
	fi
elif [ "${machine}" = Linux ]; then
    if ! shopt -oq posix; then
      if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
      elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
      fi
    fi
fi

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# tiny x if there are git changes
export GIT_PS1_SHOWDIRTYSTATE=1

# no .pyc files
export PYTHONDONTWRITEBYTECODE=1

# copy oh-my-zsh prompt
export PS1='\[\033[01;32m\]➜  \[\033[01;36m\]\W\[\033[01;31m\]$(__git_ps1)\[\033[01;36m\] \[\033[00m\] '

# add color to ls
export CLICOLOR=1

# vim4lyfe
export EDITOR="$(which vim)"

# tmux aliases
alias ta="tmux attach-session -t"
alias tl="tmux list-session"
alias tn="tmux new-session -s"

# virtualenv aliases
function virtualenv_name { echo "${PWD##*/}${1-3.7}" ; }
function vn { conda create --name "$(virtualenv_name $1)" python=${1-3.7} ; }
function va { source activate "$(virtualenv_name $1)" ; }
alias vd="conda deactivate"
alias vl="conda info --envs"
function vdd { conda remove --name "$(virtualenv_name $1)" --all ; }

# setup go
export GOPATH="${HOME}/go"
export PATH=$PATH:/usr/local/go/bin:"${GOPATH}/bin"

# Yes I want to quit, no I don't want to save anything
alias R="R --no-save"

# Helps with ipython in a virtual environment
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

# bash completion
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# add conda to PATH
export PATH="$HOME/miniconda3/bin:$PATH"

# add install-specific stuff to .localrc
source "${HOME}/.localrc"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
