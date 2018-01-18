#/bin/bash +x
# dotfiles install script
self=$(dirname $0)

# install composer tools

if [ ! -d ${HOME}/.composer ]; then
	mkdir ${HOME}/.composer
fi

ln -svf $(realpath ${self}/composer)/* ${HOME}/.composer
composer global install

# install python tools
cat ${self}/pypack.txt | xargs -n1 pipsi install

# install .config
if [ ! -d ${HOME}/.config ]; then
	mkdir ${HOME}/.config
fi

for file in $(ls ${self}/config/); do
	ln -sf $(realpath ${self}/config/${file}) ${HOME}/.config
done

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
