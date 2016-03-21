#/bin/bash +x
# dotfiles install script

# Link the Vim configs and install the plugins
ln -sfv $(pwd)/vimrc ${HOME}/.vimrc
mkdir -vp ${HOME}/.vim/{bundle,tmp}
if [ ! -d ${HOME}/.vim/bundle/Vundle.vim ] ; then
	git clone https://github.com/VundleVim/Vundle.vim.git ${HOME}/.vim/bundle/Vundle.vim
fi
vim +PluginClean +PluginInstall +qall

# create a shortcut to vim environments
ln -sfv $(pwd)/env ${HOME}/.vim/env

# Link the bashrc
ln -sfv $(pwd)/bashrc ${HOME}/.bashrc

# Link the tmux config
ln -sfv $(pwd)/tmux.conf ${HOME}/.tmux.conf

# Link the wget config
ln -sfv $(pwd)/wgetrc ${HOME}/.wgetrc

# link mintty if on cygwin
if [[ $(uname -s) =~ ^CYGWIN* ]] ; then
	ln -sfv $(pwd)/minttyrc ${HOME}/.minttyrc
fi
