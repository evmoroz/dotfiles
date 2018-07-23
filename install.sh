#/bin/bash +x
# dotfiles install script
self=$(dirname $0)

#     sudo apt-add-repository ppa:ansible/ansible
#     sudo apt-get update
#     sudo apt-get install ansible

# install .config
if [ ! -d ${HOME}/.config ]; then
	mkdir ${HOME}/.config
fi

for file in $(ls ${self}/config/); do
	ln -sf $(realpath ${self}/config/${file}) ${HOME}/.config
done
