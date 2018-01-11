#!/bin/sh

execution=start
eval set -- $(getopt -o "o" --long "opt" -n $0 -- $@)
while true; do
	case "${1}" in
		-o | --opt) execution=opt; shift;;
		--) shift; break ;;
		*) echo Unknown option: ${1}; exit 1
   	esac
done


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

git submodule init
git submodule add ${pluginurl} ${pluginpath}
git add .gitmodules ${plugindir}/${pluginname}
git commit -m "Install plugin: ${pluginname}"

vim +":helptags ${pluginpath}" +":q"
