#!/bin/sh

execution=start
path=git-plugins
while getopts "ol" name; do
	case "${1}" in
		-o) execution=opt;;
		-l) path=local;;
		*) echo Unknown option: ${1}; exit 1
   	esac
done

shift $(($OPTIND -1))

plugindir="vim/pack/${path}/${execution}"
pluginfulldir="$(dirname $0)/${plugindir}"
cd $(dirname $0)
pluginurl=${1}

if [ -z "${pluginurl}" ]; then
	echo "No url"
	exit
fi

plugin=$(basename $pluginurl)
pluginname=${plugin%.*}
pluginpath="${pluginfulldir}/${pluginname}"

echo Installing ${plugin}

if [ "${path}" != "local" ]; then
	git submodule init
	git submodule add ${pluginurl} ${pluginpath}
	git add .gitmodules ${plugindir}/${pluginname}
	git config -f .gitmodules --replace-all submodule.${pluginpath}.ignore untracked
	git commit -m "Install plugin: ${pluginname}"
else
	git clone ${pluginurl} ${pluginpath}
fi

vim +":helptags ${pluginpath}" +":q"
