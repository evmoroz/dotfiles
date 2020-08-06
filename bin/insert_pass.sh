#/bin/bash

WIN_ID=$(xdotool getactivewindow)

OUT=test
OUT=$(bw get password "$(bw list items | jq -r '.[].name' | dmenu)")
OUT=Test
[ -z "${OUT}" ] && notify-send --urgency critical -t 4000 "Could not get password" && exit 1

xdotool windowactivate --sync "${WIN_ID}" keyup --window "${WIN_ID}" Ctrl+Shift+Alt
xdotool windowactivate --sync "${WIN_ID}" type --clearmodifiers "${OUT}"
notify-send -t 4000 "Entered password"
