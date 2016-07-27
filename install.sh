#/bin/bash +x
# dotfiles install script

# Link the .vimrc
ln -sfv $(pwd)/vimrc ${HOME}/.vimrc
mkdir -vp ${HOME}/.vim/tmp # Create the temporary directory
# Remove the bundle directory if it exists
if [ ! -L ${HOME}/.vim/bundle ]; then
	echo Removing ${HOME}/.vim/bundle
	rm -rf ${HOME}/.vim/bundle
fi
ln -sfv $(pwd)/vim/bundle ${HOME}/.vim/ # create a shortcut to vim bundle
git submodule init
git submodule update

vim +Helptags +quit

# Link the inputrc
ln -sfv $(pwd)/inputrc ${HOME}/.inputrc

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
