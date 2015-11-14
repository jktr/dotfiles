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


## tweak X

xset r rate 200 30


## start daemons

[ -x ~/.fehbg ]          && ~/.fehbg &
[ -x /usr/bin/urxvtd ]   && urxvtd -q -f -o
[ -x /usr/bin/redshift ] && redshift &


## exec session

exec i3
