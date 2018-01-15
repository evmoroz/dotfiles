#!/bin/sh

execution=start
while getopts o name; do
	case "${1}" in
		o) execution=opt;;
		*) echo Unknown option: ${1}; exit 1
   	esac
done

shift $(($OPTIND -1))

plugindir="vim/pack/ttyz/${execution}"
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

git submodule init
git submodule add ${pluginurl} ${pluginpath}
git add .gitmodules ${plugindir}/${pluginname}
git commit -m "Install plugin: ${pluginname}"

vim +":helptags ${pluginpath}" +":q"
