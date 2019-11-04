### .zshenv

## locale
export LANG=en_US.UTF-8
export LC_MESSAGES=C # unexpected, non-universal translations make for bad UX

## xdg
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="/tmp/.cache-${UID}"

## path
export PATH="\
/usr/bin:/usr/sbin:\
/bin:/sbin:\
/usr/local/bin:/usr/local/sbin:\
${HOME}/bin:${HOME}/develop/bin:${HOME}/games/bin"

## preferred applications
export EDITOR='emacsclient --alternate-editor=nano --tty'
export VISUAL='emacsclient --alternate-editor=nano --tty'
export PAGER='less'
export TERMINAL='kitty -1'
if [ -n "$WAYLAND_DISPLAY" ]; then
  export BROWSER='firefox'
else
  export BROWSER='w3m'
fi

## ls colors
# prefer muted colors
# reverse broken link colors
# XXX ideally this would hook into the dircolors db
export LS_COLORS="${LS_COLORS}:\
di=01;37:\
ln=00;36:mi=00;31:or=07;36:\
so=00;35:\
ex=00;32:\
"

## ssh/gpg
export GPG_TTY="$TTY"
export SSH_ASKPASS=/usr/bin/pinentry
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"

## pass
export PASSWORD_STORE_CLIP_TIME=10
export PASSWORD_STORE_X_SELECTION=primary

## development
# go
export GOPATH="$HOME/develop/go"
export PATH="$PATH:$GOPATH/bin"
# ruby
export GEM_HOME="$HOME/develop/gems"
export PATH="$PATH:$GEM_HOME/ruby/latest/bin"
# python
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/startup.py"

## other
export IDF_PATH="$HOME/develop/esp/esp-idf"
export LESSOPEN="|/usr/bin/lesspipe.sh %s"
export MOZ_ENABLE_WAYLAND=1
export READNULLCMD="$PAGER"
export RXVT_SOCKET="${XDG_RUNTIME_DIR}/urxvtd"
