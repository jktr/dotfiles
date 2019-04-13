# .zlogin

## hacks

# editor - argument expansion with spaces in env vars
mkdir -p "${HOME}/bin"
echo -e '#!/bin/sh\nexec emacsclient --tty --alternate-editor=nano $@' > ~/bin/EDITOR
echo -e '#!/bin/sh\nexec emacsclient --create-frame --alternate-editor=emacs $@' > ~/bin/VISUAL
chmod u=rwx,g=,o= ~/bin/{EDITOR,VISUAL}

# allow configs to use runtime dir without
ln -sf "$XDG_RUNTIME_DIR" ~/.local/runtime


## systemd user units
systemctl --user start daemon.target &!
