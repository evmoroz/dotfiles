#/bin/bash +x
# dotfiles install script

# copy the Vim configs and install the plugins
cp -Rv .vimrc .vim ${HOME}
git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim
vim +PluginInstall +qall

# Copy and source the bashrc
cp .bashrc ${HOME}
source ${HOME}/.bashrc
