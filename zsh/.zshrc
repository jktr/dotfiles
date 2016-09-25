### .zshrc
### actual configuration happens in zshrc.d

zshrc_d="${XDG_CONFIG_HOME}/zsh/zshrc.d"

if [ -d $zshrc_d ] ; then
  for f in $zshrc_d/*.zshrc ; do
    [ -r "$f" ] && source "$f"
  done
fi

