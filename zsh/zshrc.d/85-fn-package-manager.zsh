### packag-manager.sh

# This provides higher-level package management
# by translating some really common operations
# to approximate platform-specific versions.
# In no way is this a replacement for the full
# package manager features; this only reduces
# some of the context switching burden.

declare -A _pm

## populate look-up table
if >/dev/null command -v 'zypper'; then
    _pm=(
        'if'   'zypper info'
        'in'   'sudo zypper install'
        'list' 'zypper search'
        'ref'  'sudo zypper refresh'
        'rm'   'sudo zypper remove'
        'se'   'zypper search'
        'up'   'sudo zypper upgrade'
    )
elif >/dev/null command -v 'pacman'; then
    _pm=(
        'if'   'pacman --sync --info'
        'in'   'sudo pacman --sync'
        'list' 'pacman --query'
        'ref'  'sudo pacman --sync --refresh'
        'rm'   'sudo pacman --remove --nosave --recursive --cascade'
        'se'  'pacman --sync --search'
        'up'   'sudo pacman --sync --sysupgrade'
    )
elif >/dev/null command -v 'apt'; then
    _pm=(
        'if'   'apt show'
        'in'   'sudo apt install'
        'list' 'dpkg --list'
        'ref'  'sudo apt update'
        'rm'   'apt purge'
        'se'   'apt search'
        'up'   'sudo apt upgrade'
    )
elif >/dev/null command -v 'apt-get'; then
    _pm=(
        'if'   'apt-cache show'
        'in'   'sudo apt-get install'
        'list' 'dpkg --list'
        'ref'  'sudo apt-get update'
        'rm'   'sudo apt-get purge'
        'se'   'apt-cache search'
        'up'   'sudo apt-get dist-upgrade'
    )
elif >/dev/null command -v 'apk'; then
    _pm=(
        'if'   'apk info'
        'in'   'su - apk add --no-cache'
        'list' 'dpkg --list'
        'ref'  'su - apk update'
        'rm'   'su - apk del'
        'se'   'apk search'
        'up'   'su - apk upgrade'
    )
fi

_pm['usage']='echo usage: pm [CMD [ARGS]]'
            
# runs command from look-up table
pm () {
    echo \$ ${_pm[${@[1]:-'usage'}]} ${@: 2}
    ${_pm[${@[1]:-'usage'}]} ${@: 2}
}
