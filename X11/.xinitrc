### .xinitrc
# sets up the X11 environment from scratch

## paths

xresources_sys='/etc/X11/xinit/.Xresources'
xmodmap_sys='/etc/X11/xinit/.Xmodmap'
xinitrcd_sys='/etc/X11/xinit/xinitrc.d'

xsession_usr="${HOME}/.xsession"


## basic X11 initialization

xmodmap=$(command -v xmodmap || echo 'true')
xrdb=$(command -v xrdb || echo 'true')
xset=$(command -v xset || echo 'true')

# system's keymaps
[ -r "$xmodmap_sys" ] && $xmodmap $xmodmap_sys

# system's .Xresources
[ -r "$xresources_sys" ] && $xrdb -merge $xresrouces_sys

# system's xinitrc.d
if [ -d "$xinitrcd_sys" ] ; then
  for f in "$xinitrcd"/*.sh ; do
    [ -x "$f" ] && source "$f"
  done
fi


## user session (or setup file)

if [ -x $xsession_usr ]; then
    if [ "$(file --dereference --brief --mime-type $xsession_usr)" = 'text/x-shellscript' ]; then
        # source user file so that we can try fallbacks if not exec'ing
        . "$xsession_usr"
    else
        exec "$xsession_usr"
    fi
else
    echo >&2 "Your $xsession_usr isn't executable!"
fi

## fallback
## in case of missing, unexecutable, or non-exec'ing user session

echo >&2 "Oh noes, something isn't right! Falling back to default X11 session."

# try to invoke user's TERMINAL, falling back to xterm
[ -n "$TERMINAL" ] && exec "$TERMINAL"
exec xterm
