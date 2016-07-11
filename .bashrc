# add git prompt
# https://github.com/git/git/tree/master/contrib/completion
DOTFILES="${HOME}/.dotfiles"

GIT_PROMPT="${DOTFILES}/.git-prompt.sh"
GIT_COMPLETION="${DOTFILES}/.git-completion.sh"

if [ -f "${GIT_PROMPT}" ]; then source "${GIT_PROMPT}"; fi
if [ -f "${GIT_COMPLETION}" ]; then source "${GIT_COMPLETION}"; fi

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

# setup go
export GOPATH="${HOME}/go"
export PATH=$PATH:"${GOPATH}/bin"

# node env vars
export NVM_DIR=~/.nvm

# git aliases
alias gcommits="git shortlog -n --since='one week'"
alias gbranch="git for-each-ref --sort=-committerdate --format '%(color:green)%(authorname)%(color:reset)%09%(committerdate)%09%(color:green)%(refname)%(color:reset)%09%(subject)' refs/heads/"

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
source ~/.localrc

# archey gives some stats on the machine and draws a picture
# `brew install archey`
if which archey > /dev/null; then archey; fi
