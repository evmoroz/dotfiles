#/bin/bash +x
# dotfiles install script

# Link the Vim configs and install the plugins
ln -sfv $(pwd)/.vimrc ${HOME}/
mkdir -vp ${HOME}/.vim/{bundle,tmp}
if [ ! -d ${HOME}/.vim/bundle/Vundle.vim ] ; then
	git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim
fi
vim +PluginInstall +qall

# Link the bashrc
ln -sfv $(pwd)/.bashrc ${HOME}/

# Link the tmux config
ln -sfv $(pwd)/.tmux.conf ${HOME}/

# link mintty if on cygwin
if [[ $(uname -s) =~ ^CYGWIN* ]] ; then
	ln -sfv $(pwd)/.minttyrc ${HOME}/
fi
