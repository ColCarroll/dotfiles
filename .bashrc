#!/bin/bash

# git completion, and other bash completion
if [ -f "$(brew --prefix)/etc/bash_completion" ]; then
    . "$(brew --prefix)/etc/bash_completion"
fi

# tiny x if there are git changes
export GIT_PS1_SHOWDIRTYSTATE=1

# no .pyc files
export PYTHONDONTWRITEBYTECODE=1

# copy oh-my-zsh prompt
export PS1='\[\033[01;32m\]➜  \[\033[01;36m\]\W\[\033[01;31m\]$(__git_ps1)\[\033[01;36m\] \[\033[00m\] '

# add color to ls
export CLICOLOR=1

# vim4lyfe
export EDITOR="/usr/local/bin/vim"

# tmux aliases
alias ta="tmux attach-session -t"
alias tl="tmux list-session"
alias tn="tmux new-session -s"

# virtualenv aliases
function virtualenv_name { echo "${PWD##*/}${1-3.6}" ; }
function vn { conda create --name "$(virtualenv_name $1)" python=${1-3.6} ; }
function va { source activate "$(virtualenv_name $1)" ; }
alias vd="source deactivate"
alias vl="conda info --envs"
function vdd { conda remove --name "$(virtualenv_name $1)" --all ; }

# setup go
export GOPATH="${HOME}/go"
export PATH=$PATH:"${GOPATH}/bin"

# node env vars
export NVM_DIR=~/.nvm

# Yes I want to quit, no I don't want to save anything
alias R="R --no-save"

# Helps with ipython in a virtual environment
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

# bash completion
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

# add install-specific stuff to .localrc
source "${HOME}/.localrc"
