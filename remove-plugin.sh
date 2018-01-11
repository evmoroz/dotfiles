#!/bin/bash
plugin=${1}
plugindir="$(dirname $0)/vim/pack/ttyz"

if [ -z ${plugin} ]; then
	for pluginname in $(ls ${plugindir}/start); do
		echo -e "${pluginname} \e[90m[$(git --git-dir=${plugindir}/start/${pluginname}/.git remote get-url origin)]\e[0m"
	done

	echo -e "\nOptional plugins:"
	for pluginname in $(ls ${plugindir}/opt); do
		echo -e "${pluginname} \e[90m[$(git --git-dir=${plugindir}/opt/${pluginname}/.git remote get-url origin)]\e[0m"
	done
	exit 0
fi

pluginstartpath="${plugindir}/start/${plugin}"
pluginoptpath="${plugindir}/opt/${plugin}"

echo "Removing ${pluginpath}..."

if [ -d "${pluginstartpath}" ]; then
	pluginpath=${pluginstartpath}
	
fi

if [ -d "${pluginoptpath}" ]; then
	pluginpath=${pluginoptpath}
fi

if [ -z "${pluginpath}" ]; then
	echo "Could not find ${plugin}."
	exit 1
fi

git submodule deinit ${pluginpath}
git rm ${pluginpath}
rm -Rf .git/modules/${pluginpath}
git commit -m "Remove plugin: ${plugin}"
