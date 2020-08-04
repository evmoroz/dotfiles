#!/bin/bash
set -euo pipefail
eval $(secret env)
lock -l restic --wait 1m --retry 5

tags=("$(uname -r)")
[ -n "${1:-}" ] && tags+=("${1}")

function on_error {
    local rc=$?
    lock -l restic unlock
    [ $rc -ne 0 ] && \
       logger -t backup -p err "Backup failed" --id=$$
    exit $rc
}
trap on_error EXIT

notify-send --expire-time=5000 "Backup started"

dest=/data/backups
export RESTIC_PASSWORD_COMMAND="bw get password backup"

{ {
    restic -r "${dest}" \
        forget \
        --keep-last=2 \
        --keep-hourly=8 \
        --keep-daily=7 \
        --keep-weekly=8 \
        --keep-monthly=12 \
        --keep-yearly=3 \
        --host=$(hostname) \
        --group-by=host

    restic -r "${dest}" \
        --verbose \
        --exclude-caches \
        --one-file-system \
        --exclude-file=${HOME}/.local/excludes \
        ${tags[@]/#/--tag } \
        backup / /boot /home

    restic -r "${dest}" check
} 2>&1 1>&3 3>&- | logger -t backup -p err --id=$$ ; } 3>&1 1>&2 | logger -t backup -p info --id=$$

notify-send --expire-time=10000 "Backup successful"
