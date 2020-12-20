# enable the runtime dir for configs without env var interpolation
[ -n "$XDG_RUNTIME_DIR" ] && ln -sf "$XDG_RUNTIME_DIR" ~/.local/runtime

# start session daemons
systemctl --user start daemon.target &!

# launch graphical environment
if [ "$XDG_VTNR" -eq 1 ] && [ -z "$WAYLAND_DISPLAY" ]; then

  # XXX: ensure zsh picks up vars that depend on the graphical env
  export WAYLAND_DISPLAY=wayland-$RANDOM
  . ~/.zshenv
  unset WAYLAND_DISPLAY

  # XXX: various wayland compatability settings
  export XDG_SESSION_TYPE=wayland
  export MOZ_ENABLE_WAYLAND=1

  exec systemd-cat --identifier=sway sway
fi
