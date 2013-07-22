#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="pylintrc bashrc vimrc gvimrc"    # list of files/folders to symlink in homedir
bundle=~/.vim/bundle  # vim plugin directory
vimauto=~/.vim/autoload # vim autoload directory

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo -e "done\n"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo -e "done\n"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    if [ -f ~/.$file ];
    then
      echo "Moving $file from ~ to $olddir"
      mv ~/.$file ~/dotfiles_old/$file
    fi
    echo -e "Creating symlink to $file in home directory.\n"
    ln -snf $dir/$file ~/.$file
done

# Make .vim folder, install pathogen there
mkdir -p $vimauto $bundle; 
curl -Sso $vimauto/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim
ln -s $dir/colors ~/.vim/colors

# Add some vim plugins
cd $bundle
git clone https://github.com/scrooloose/syntastic.git #syntastic for syntax checking
git clone https://github.com/scrooloose/nerdtree.git #nerdtree menu
git clone https://github.com/ervandew/supertab.git #tab completion
git clone https://github.com/tpope/vim-fugitive.git #fugitive git support
git clone https://github.com/vim-scripts/HTML-AutoCloseTag.git #html auto close tag
