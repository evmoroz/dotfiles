#/bin/bash +x
# dotfiles install script

# copy the Vim configs and install the plugins
cp -v .vimrc ${HOME}
mkdir -vp ${HOME}/.vim/{bundle,tmp}
if [ ! -d ${HOME}/.vim/bundle/Vundle.vim ] ; then
	git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall

# Copy and source the bashrc
cp -v .bashrc ${HOME}
source ${HOME}/.bashrc

# Copy tmux config
cp -v .tmux.conf ${HOME}
