#!/bin/sh

if [ -f ${HOME}/.local.tmux.conf ]; then
    tmux source-file ${HOME}/.local.tmux.conf
fi
