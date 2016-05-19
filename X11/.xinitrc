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

existp () {
    # (portably) check for binary on path and execute permissions
    local location=$(command -v $1)
    test "$?" -eq "0" -a -x "$location"
}

existp_and_bg () {
    if existp "$1"; then
        nohup $1 &
        disown
    fi
}

# UI
existp_and_bg ~/.fehbg
existp_and_bg redshift
existp_and_bg dunst

# less overhead for many instances
existp urxvtd && /usr/bin/urxvtd -q -f -o
existp emacs  && emacs --daemon 


## exec session

exec i3
