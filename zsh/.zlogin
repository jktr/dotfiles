# .zlogin

## editor - requires some hacks b/c argument expansion with spaces
mkdir -p "${HOME}/bin"
echo -e '#!/bin/sh\nexec emacsclient --tty --alternate-editor=nano $@' > ~/bin/EDITOR
echo -e '#!/bin/sh\nexec emacsclient --create-frame --alternate-editor=emacs $@' > ~/bin/VISUAL
chmod u=rwx,g=,o= ~/bin/{EDITOR,VISUAL}

## systemd user units
systemctl --user start daemon.target &!

## systemd user units - X11 specific
if [ -n "$DISPLAY" ]; then
    systemctl --user import-environment XAUTHORITY DISPLAY
    systemctl --user start X11.target
fi
