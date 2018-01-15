#/bin/bash +x
# dotfiles install script

# Link the .vimrc
ln -sfv $(pwd)/vimrc ${HOME}/.vimrc
# Remove the .vim directory if it exists
if [ -d ${HOME}/.vim ]; then
	echo Removing ${HOME}/.vim
	rm -rf ${HOME}/.vim
fi
ln -sfv $(pwd)/vim ${HOME}/.vim # create a link to .vim
mkdir -vp ${HOME}/.vim/tmp # Create the temporary directory
git submodule sync
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
