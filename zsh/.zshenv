# .zshenv

# locale
export LANG=en_US.UTF-8
export LC_MESSAGES=C # unexpected, non-universal translations make for bad UX

# xdg
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="/tmp/.cache-${UID}"
export XDG_RUNTIME_DIR="/run/user/${UID}"

# editor
#   requires some hacks b/c argument expansion with spaces
#   see: .zlogin
export EDITOR="${HOME}/bin/EDITOR"
export VISUAL="${HOME}/bin/VISUAL"

# pager
export PAGER='less'

# terminal
export TERMINAL='urxvtc'

# www-browser
export BROWSER='firefox'

# path
export PATH="${PATH}:${HOME}/bin:${HOME}/develop/bin:${HOME}/games/bin"

# misc
export RXVT_SOCKET="/run/user/${UID}/urxvtd"
