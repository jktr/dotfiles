#!/bin/sh

### .xsession
# sets up and exec's a custom X11 sessions
# Previous site initialiation is assumed.

## user's paths

xmodmap_usr="${HOME}/.Xmodmap"
xresources_usr="${HOME}/.Xresources"


## user's initialization

# ensure we have the needed xorg commands
xmodmap=$(command -v xmodmap || echo 'true')
xrdb=$(command -v xrdb || echo 'true')
xset=$(command -v xset || echo 'true')
setxkbmap=$(command -v setxkbmap || echo 'true')

# set keyboard layout
# alternative layout while alternate-graphic key is held
$setxkbmap -option && $setxkbmap en_US,de -option grp:switch,nbsp:level2

# load custom keyboard remappings
[ -r "$xmodmap_usr" ] && $xmodmap $xmodmap_usr

# merge user resources
[ -r "$xresources_usr" ] && $xrdb -merge $xresources_usr

# set keyboard repeat rate
$xset r rate 200 30

# start X11-dependant systemd units
{
    systemctl --user import-environment XAUTHORITY DISPLAY
    systemctl --user start X11.target
} &


## exec session

exec i3
