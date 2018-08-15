
pane_address() {
    tmux display-message -p "#S:#I.#{pane_index}"
}

auto_share() {
    # if [ -z "$(diff -u <(cat /tmp/tbar/dump.env | grep -P "^(${AUTO_SHARE})=" | sort ) <(printenv | grep -P "^(${AUTO_SHARE})=" | sort))"]; then
    #     return
    # fi

    printenv | grep -P "^(${AUTO_SHARE})=" | tr "\n" ';' | nc 127.0.0.1 50000
}

tbar() {
    if [ -z "$1" ]; then
        ~/lab/tbar/tbar.sh
        return
    fi

    for v in "${@}"; do echo -en "${v};"; done  | nc 127.0.0.1 50000
}


tbar_update_env() {
    if [ ! -f /tmp/tbar/dump.env ]; then return; fi
    while read line; do
        if [ -z "$line" ]; then
            continue
        fi

        export "$line"
    done < /tmp/tbar/dump.env
}
