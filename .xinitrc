#!/bin/sh

## merge in .Xresources

sysrsrc=/etc/X11/xinit/.Xresources 
usrrsrc=~/.Xresources
[ -f "$sysrsrc" ] && xrdb -merge $sysrsrc
[ -f "$usrrsrc" ] && xrdb -merge $usrrsrc


## load keymaps

sysmodmap=/etc/X11/xinit/.Xmodmap
[ -f "$sysmodmap" ] && xmodmap $sysmodmap


## run global xinitrc.d files

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
  for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
    [ -x "$f" ] && source "$f"
  done
fi


## setup

xset r rate 200 30

## exec session

exec i3
