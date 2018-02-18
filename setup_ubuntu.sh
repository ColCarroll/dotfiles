#!/usr/bin/bash
set -e # exit on error

echo -e "\nAdding ppas for libraries"
APT_PPAS=(
  "https://cran.rstudio.com/bin/linux/ubuntu xenial/"  # for R
)

for ppa in "${APT_PPAS[@]}"; do
  if ! grep -q "^deb .*${ppa}" /etc/apt/sources.list /etc/apt/sources.list.d/*;
    then
      echo foo "'"deb "${ppa}'"
      add-apt-repository "deb ${ppa}"
    else
      echo ${ppa} already in sources
  fi
done
  

echo -e "\nUpdate apt"
apt-get update

echo -e "\nInstalling packages from apt"
APT_PACKAGES=(
  "bash" # might as well get an updated terminal shell
  "git" # version control https://git-scm.com/
  "vim" # vim4lyfe http://www.vim.org/
  "tmux" # window management https://tmux.github.io/
  "jq" # handle json from command line  https://github.com/stedolan/jq
  "golang-go" # fun programming https://golang.org/
  "r-base" # make hadley proud https://cran.r-project.org/
)

for pkg in "${APT_PACKAGES[@]}"; do
  if ! dpkg-query -W -f='${Status}' "${pkg}" 2>/dev/null | grep -c "ok installed";
  then
    echo "Installing $pkg"
    apt-get -y install "$pkg"
  else
    echo "$pkg already installed"
  fi
done

echo -e "\nInstalling python versions"
if conda --version > /dev/null 2>&1;
  then
    echo "conda appears to already be installed"
  else
    INSTALL_FOLDER="$HOME/miniconda3"
    if [ ! -d ${INSTALL_FOLDER} ] || [ ! -e ${INSTALL_FOLDER/bin/conda} ];
      then
        DOWNLOAD_PATH="miniconda.sh"
        wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ${DOWNLOAD_PATH};
        echo "Installing miniconda to ${INSTALL_FOLDER}"
        bash ${DOWNLOAD_PATH} -b -f -p ${INSTALL_FOLDER}
        rm ${DOWNLOAD_PATH}
      else
        echo "Miniconda already installed at ${INSTALL_FOLDER}"
    fi
fi


echo -e "\nSymlinking some files"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
FILES_TO_LINK=(
  ".bashrc" # bash configuration
  ".vimrc" # vim goodness
  ".tmux.conf" # tmux configuration
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
LOCALRC="${HOME}/.localrc"
if ! [ -f "${LOCALRC}" ]; then
  echo "Creating empty $LOCALRC"
  touch "${LOCALRC}"
fi

echo -e "\nAll done! You may need to add \`source ~/.bashrc\` in ~/.bash_profile"
