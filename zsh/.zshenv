### .zshenv

## locale
export LANG=en_US.UTF-8
export LC_MESSAGES=C # unexpected, non-universal translations make for bad UX

## xdg
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="/tmp/.cache-${UID}"
export XDG_RUNTIME_DIR="/run/user/${UID}"

## path
export PATH="\
/usr/bin:/usr/sbin:\
/bin:/sbin:\
/usr/local/bin:/usr/local/sbin:\
${HOME}/bin:${HOME}/develop/bin:${HOME}/games/bin"

## preferred applications
# editor requires some hacks b/c argument expansion with spaces; see: .zlogin
export EDITOR="${HOME}/bin/EDITOR"
export VISUAL="${HOME}/bin/VISUAL"
export PAGER='less'
export TERMINAL='urxvtc'
export BROWSER='firefox'

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

## go
export GOPATH="$HOME/develop/go"
export PATH="$PATH:$GOPATH/bin"

## ruby
export GEM_HOME="$HOME/develop/gems"
export PATH="$PATH:$GEM_HOME/ruby/latest/bin"

## other
export LESSOPEN="|/usr/bin/lesspipe.sh %s"
export READNULLCMD="$PAGER"
export RXVT_SOCKET="${XDG_RUNTIME_DIR}/urxvtd"
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
