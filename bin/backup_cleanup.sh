#!/bin/bash
set -euo pipefail
eval $(secret env)
lock -l restic --wait 1m --retry 5

function on_error {
    local rc=$?

    lock -l restic unlock
    [ $rc -ne 0 ] && \
        logger -p err --id=$$ -t backup "Cleanup failed"
    exit $rc
}
trap on_error EXIT

notify-send --expire-time=5000 "Cleanup started"

dest=/data/backups
export RESTIC_PASSWORD_COMMAND="bw get password backup"

{ {
    restic -r "${dest}" prune
    restic -r "${dest}" check
} 2>&1 1>&3 3>&- | logger -t backup -p err --id=$$ ; } 3>&1 1>&2 | logger -t backup -p info --id=$$

notify-send --expire-time=10000 "Cleanup successful"
