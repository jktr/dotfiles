### .zshrc
### actual configuration happens in zshrc.d

if [ -n "${XDG_CONFIG_HOME}" ]; then
  _zshrc_d="${XDG_CONFIG_HOME}/zsh/zshrc.d"
else
  # fallback if XDG is not in use
  _zshrc_d=~/.zshrc.d
fi

setopt null_glob
if [ -d $_zshrc_d ] ; then
  for f in $_zshrc_d/*.{z,}sh; do
    [ -r "$f" ] && source "$f"
  done
fi

