### .zshrc

setopt null_glob
if [ -d "${XDG_CONFIG_HOME}/zsh/zshrc.d" ] ; then
  for f in "${XDG_CONFIG_HOME}/zsh/zshrc.d"/*.{z,}sh; do
    [ -r "$f" ] && . "$f"
  done
fi

