#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

~/.screenlayout/arandr.sh
xset r rate 250 30
setxkbmap -option grp:win_space_toggle us,ru
setxkbmap -option grp_led:scroll
setxkbmap -option compose:ralt
setxkbmap -option caps:none

xrdb -merge /home/emorozov/.config/Xresources

secret export -n DBUS_SESSION_BUS_ADDRESS

journal-errors -p err &
xscreensaver -no-splash -no-capture-stderr &

exec i3
