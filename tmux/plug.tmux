#!/usr/bin/env bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

declare -A interpolate

for file in $(ls $DIR/scripts); do
    interpolate[$file]=$(realpath $DIR/scripts/$file)
done

for file in $(ls $DIR/local); do
    interpolate[$file]=$(realpath $DIR/local/$file)
done

tmux_set_opt() {
    local option="$1"
    local value="$(get_tmux_option "$option")"
    for i in ${!interpolate[@]}; do
        value=${value//\#\{${i}\}/\#\(${interpolate[$i]}\)}
    done

    tmux set-option -gq "${option}" "${value}"
}


get_tmux_option() {
    local option="$1"
    local default_value="$2"
    local option_value="$(tmux show-option -gqv "$option")"
    echo "${option_value:-$default_value}"
}

main() {
    tmux_set_opt "status-left"
    tmux_set_opt "status-right"
}

main

