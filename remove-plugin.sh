#!/bin/bash
plugin=${1}
plugindir="$(dirname $0)/vim/bundle"

if [ -z ${plugin} ]; then
	echo "Select plugin (${plugindir})"
	for pluginname in $(ls ${plugindir}); do
		echo -e "${pluginname} \e[90m[$(git --git-dir=${plugindir}/${pluginname}/.git remote get-url origin)]\e[0m"
	done
	exit 0
fi

pluginpath="${plugindir}/${plugin}"

echo "Removing ${pluginpath}..."

if [ ! -d "${pluginpath}" ]; then
	echo "Could not find ${plugin}."
	exit 1
fi

git submodule deinit ${pluginpath}
git rm ${pluginpath}
rm -Rf .git/modules/${pluginpath}
git commit -m "Remove plugin: ${plugin}"
