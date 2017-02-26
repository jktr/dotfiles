#!/bin/sh

# start X11-dependent programs via systemd
{
    systemctl --user import-environment XAUTHORITY DISPLAY XDG_CONFIG_HOME
    systemctl --user restart X11.target
} &
disown

## exec session

exec i3
