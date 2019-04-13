# allow configs to use runtime dir without
ln -sf "$XDG_RUNTIME_DIR" ~/.local/runtime


## systemd user units
systemctl --user start daemon.target &!
