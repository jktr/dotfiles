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
export PATH="${PATH}:/sbin:/usr/sbin" # add sbin for restrictive defaults
export PATH="${PATH}:${HOME}/bin:${HOME}/develop/bin:${HOME}/games/bin"

## universal
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
di=00;37:\
ln=00;36:mi=00;31:or=07;36:\
so=00;35:\
ex=00;32:\
"

# less preprocessor
export LESSOPEN="|/usr/bin/lesspipe.sh %s"

## other
export SSH_ASKPASS=''
export RXVT_SOCKET="/run/user/${UID}/urxvtd"
export XINITRC="${XDG_CONFIG_HOME}/X11/xinitrc"
