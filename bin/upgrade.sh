#!/bin/bash
set -euo pipefail
$(secret env)

dotfiles_dir=$(realpath $(dirname $(readlink -f "$0"))/..)
skip_backup=
skip_av=
skip_docker=
skip_update=
skip_git=
new_pkg=()
global=

while [ $# -gt 0 ]; do
    opt=${1}
    shift
    case ${opt} in
        --skip-backup) skip_backup=1;;
        --skip-av) skip_av=1;;
        --skip-docker) skip_docker=1;;
        --skip-update) skip_update=1;;
        --skip-git) skip_git=1;;
        -i|--install) new_pkg+=(${1}) && shift;;
        -g|--global) global=1;;
        -d|--dotfiles) dotfiles_dir=${1} && shift;;
        --debug) set -x;;
        *) echo "Unknown option ${opt}" && exit 1;;
    esac

done

if [ -z "${skip_backup}" ]; then
    echo "creating a backup"
    backup.sh update
fi

if [ -z "${skip_docker}" ]; then
    echo "docker cleanup"
    docker container prune --force --filter "until=24h"
    docker image prune --force --all --filter "until=1440h"
    docker image prune --force --filter "until=72h"
    docker network prune --force
    docker volume prune --force

    docker pull wernight/phpcs:latest
fi

if [ -z "${skip_av}" ]; then
    echo "update clamav"
    sudo freshclam
fi

echo "fetch dotfiles"
git -C ${dotfiles_dir} fetch
git -C ${dotfiles_dir} rebase

if [ -z "${skip_update}" ]; then
    remove_pkg=$(pacman -Qtdq || true)
    if [ -n "${remove_pkg}" ]; then
        echo "Reomve packages that are no longer required"
        sudo pacman -Rns ${remove_pkg}
    fi
    echo "Upgrade"
    sudo pacman -Syu
fi

if [ -n "${new_pkg}" ] ; then
    file=${dotfiles_dir}/pkglist.txt
    [ -z "${global}" ] && \
        file=pkglist.$(hostname).txt && \
        msg=" on $(hostname)"

    for pkg in "${new_pkg[@]}"; do
        echo "added ${pkg}"
        echo "${pkg}" >> ${file}
    done

    sort -o ${file} ${file}
    git -C ${dotfiles_dir} add ${file}
    git -C ${dotfiles_dir} commit -m "install ${pkg[@]}${msg:-}"
    git -C ${dotfiles_dir} push
fi

echo "install new packages"
cat ${dotfiles_dir}/pkglist{.$(hostname),}.txt | pacman --needed -S -

echo "Cleanup"
sudo pacman -Sc

if [ -z "${skip_git}" ]; then
echo "fetch git repos"
ls -d --color=none ${HOME}/aur/* ${HOME}/.vim/pack/git-plugins/{opt,start}/* | \
    xargs -n1 -I{} echo "git -C {} clean -df && git -C {} fetch && git -C {} rebase >/dev/null" | \
    parallel
fi
