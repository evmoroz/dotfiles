#/bin/bash +x
# dotfiles install script

# Link the .vimrc
ln -sfv $(pwd)/vimrc ${HOME}/.vimrc
mkdir -vp ${HOME}/.vim/tmp # Create the temporary directory
ln -sfv $(pwd)/vim/bundle ${HOME}/.vim/bundle # create a shortcut to vim bundle

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
