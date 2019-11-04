# enable the runtime dir for configs without env var interpolation
ln -sf "$XDG_RUNTIME_DIR" ~/.local/runtime

# start session daemons
systemctl --user start daemon.target &!

# launch graphical environment
if [ $XDG_VTNR -eq 1 ] && [ -z "$WAYLAND_DISPLAY" ]; then

  # XXX: ensure sway picks up vars that depend on the graphical env
  export WAYLAND_DISPLAY=wayland-$RANDOM
  . ~/.zshenv

  exec sway
fi
