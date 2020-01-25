# enable the runtime dir for configs without env var interpolation
ln -sf "$XDG_RUNTIME_DIR" ~/.local/runtime

# start session daemons
systemctl --user start daemon.target &!

# launch graphical environment
if [ $XDG_VTNR -eq 1 ] && [ -z "$WAYLAND_DISPLAY" ]; then

  # XXX: ensure sway picks up vars that depend on the graphical env
  export WAYLAND_DISPLAY=wayland-$RANDOM
  . ~/.zshenv

  # XXX: various wayland compatability settings
  export XDG_SESSION_TYPE=wayland
  export MOZ_ENABLE_WAYLAND=1
  export SDL_VIDEODRIVER=wayland
  export QT_QPA_PLATFORM=wayland
  export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"

  exec sway
fi
