#!/bin/sh

## PATHS

# commands
xrdb=/usr/bin/xrdb
xmodmap=/usr/bin/xmodmap

# user
usrrsrc=~/.Xresources

# system
sysrsrc=/etc/X11/xinit/.Xresources 
sysmodmap=/etc/X11/xinit/.Xmodmap
xinitrcd=/etc/X11/xinit/xinitrc.d


## X11 CONF

# .Xresources
[ -f "$sysrsrc" ] && $xrdb -merge $sysrsrc
[ -f "$usrrsrc" ] && $xrdb -merge $usrrsrc

# keymaps
[ -f "$sysmodmap" ] && $xmodmap $sysmodmap

# system xinitrc.d
if [ -d $xinitrcd ] ; then
  for f in $xinitrcd/*.sh ; do
    [ -x "$f" ] && source "$f"
  done
fi

# adjust keyboard repeat
[ -x $xset ] && $xset r rate 200 30


## X11 DAEMONS

systemctl --user start X11.target


## EXEC SESSION

exec i3
