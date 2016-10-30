# .zlogin

## hacks

# editor - argument expansion with spaces in env vars
mkdir -p "${HOME}/bin"
echo -e '#!/bin/sh\nexec emacsclient --tty --alternate-editor=nano $@' > ~/bin/EDITOR
echo -e '#!/bin/sh\nexec emacsclient --create-frame --alternate-editor=emacs $@' > ~/bin/VISUAL
chmod u=rwx,g=,o= ~/bin/{EDITOR,VISUAL}

# link to /run/user/UID from configs that don't know UID
ln -sf /run/user/${UID} ~/.local/run-user-dir

## systemd user units
systemctl --user start daemon.target &!
