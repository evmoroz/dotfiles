#!/bin/sh

plugindir="vim/pack/ttyz/start"
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
