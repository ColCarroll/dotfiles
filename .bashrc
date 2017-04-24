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
function virtualenv_dir { echo "$HOME"/.venv/"${PWD##*/}" ; }
function vn { [ ! -d $(virtualenv_dir) ] && virtualenv $(virtualenv_dir) ; }
function va { source $(virtualenv_dir)/bin/activate ; }
alias vd="deactivate"

# setup go
export GOPATH="${HOME}/go"
export PATH=$PATH:"${GOPATH}/bin"

# node env vars
export NVM_DIR=~/.nvm

# git aliases
alias gcommits="git shortlog -n --since='one week'"
alias gbranch="git for-each-ref --sort=-committerdate --format '%(color:green)%(authorname)%(color:reset)%09%(committerdate)%09%(color:green)%(refname)%(color:reset)%09%(subject)' refs/heads/"

# Yes I want to quit, no I don't want to save anything
alias R="R --no-save"

# Helps with ipython in a virtual environment
alias ipy="python -c 'import IPython; IPython.terminal.ipapp.launch_new_instance()'"

# "unlimited" ~/.bash_history with timestamps
export HISTTIMEFORMAT="%F %T "
export HISTSIZE= HISTFILESIZE=
shopt -s histappend

# bash completion
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

# sets up pyenv if it is installed
# `brew install pyenv`
export PYENV_ROOT=/usr/local/var/pyenv
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# add install-specific stuff to .localrc
source "${HOME}/.localrc"

# archey gives some stats on the machine and draws a picture
# `brew install archey`
if which archey > /dev/null; then archey; fi
