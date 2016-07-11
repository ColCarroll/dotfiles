# dotfiles

My personal dotfiles.  Just run `bash setup.sh`.  It should tell you what it does.

The most brittle bit is probably `pyenv`.  You will probably want to set default pythons, or install
your own, in `~/.localrc`.  For example, add the line `pyenv global 2.7.12 3.5.2`, which will mean
that `python` and `python2` give you `python 2.7.12`, while `python3`, or `python3.5` will give you
`python 3.5.2`.
