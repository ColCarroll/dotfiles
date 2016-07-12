#!/usr/bin/bash
set -e # exit on error


# Install homebrew if not already installed
if ! which brew > /dev/null;
then
    echo "Installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

echo -e "\nUpdating homebrew"
brew update

echo -e "\nInstalling packages from brew cask"
BREW_CASK_PACKAGES=(
  "java" # better than figuring out oracle's website http://www.oracle.com/technetwork/java/javase/downloads/jdk8-downloads-2133151.html
)

for pkg in "${BREW_CASK_PACKAGES[@]}"; do
  if ! brew cask list -1 | grep -q "^${pkg}\$";
  then
    echo "Installing $pkg"
    brew cask install "$pkg"
  else
    echo "$pkg already installed"
  fi
done

echo -e "\nTapping homebrew/science"
brew tap homebrew/science


echo -e "\nInstalling packages from regular brew"
BREW_PACKAGES=(
  "bash" # might as well get an updated terminal shell
  "git" # version control https://git-scm.com/
  "gcc" # gnu compiler collection https://gcc.gnu.org/
  "vim" # vim4lyfe http://www.vim.org/
  "tmux" # window management https://tmux.github.io/
  "wget" # curl alternative https://www.gnu.org/software/wget/
  "jq" # handle json from command line  https://github.com/stedolan/jq
  "archey" # pretty startup script https://obihann.github.io/archey-osx/
  "go" # fun programming https://golang.org/
  "r" # make hadley proud https://cran.r-project.org/
  "pyenv" # manage python versions.  https://github.com/yyuu/pyenv
  "nvm" # manage node versions https://github.com/creationix/nvm
  "node" # javascript runtime https://nodejs.org/en/
)

for pkg in "${BREW_PACKAGES[@]}"; do
  if ! brew list -1 | grep -q "^${pkg}\$";
  then
    echo "Installing $pkg"
    brew install "$pkg"
  else
    echo "$pkg already installed"
  fi
done

echo -e "\nInstalling python versions"
PYTHON_VERSIONS=( # get the latest 2.x and 3.x pythons
  "2.7.12"
  "3.5.2"
)

for version in "${PYTHON_VERSIONS[@]}"; do
  if ! pyenv versions | grep -q "${version}";
  then
    echo "Installing python $version"
    pyenv install "$version"
  else
    echo "Python $version already installed"
  fi
done


echo -e "\nSymlinking some files"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILES_TO_LINK=(
  ".bashrc" # bash configuration
  ".vimrc" # vim goodness
)
for filename in "${FILES_TO_LINK[@]}"; do
  file="${DIR}/${filename}"
  if ! [ -f "${file}" ]; then
    echo "${file} does not exist!  Exiting..."
    exit 1;
  fi
  target="${HOME}/${filename}"
  if ! [ -f "${target}" ];
  then
    echo "Making symlink for $file"
    ln -s "${file}" "${target}";
  else
    echo "${target} already exists"
  fi
done

echo -e "\nInstalling vundle plugins"
VUNDLE_DIR=~/.vim/bundle/Vundle.vim
if ! [ -d ${VUNDLE_DIR} ]; then
  echo "Cloning vundle to $VUNDLE_DIR"
  git clone https://github.com/VundleVim/Vundle.vim.git "${VUNDLE_DIR}"
fi

echo -e "\nInstalling vim plugins"
vim +PluginInstall +qall

echo -e "\nMaking sure localrc exists"
LOCALRC=~/.localrc
if ! [ -f ${LOCALRC} ]; then
  echo "Creating empty $LOCALRC"
  touch "${LOCALRC}"
fi

source "${HOME}/.bashrc"

echo -e "The following packages are outdated and may be upgraded using \`brew upgrade $PKG\`:\n"
brew outdated

echo -e "\nAlso, you may need to add \`source ~/.bashrc\` in ~/.bash_profile"
