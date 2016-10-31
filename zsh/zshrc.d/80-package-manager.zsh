### package-manager.sh
###
### provides high-level package management by wrapping
### the platform's package manager

declare -A _pm

## populate look-up table
if hash 'zypper' 2>/dev/null; then
    _pm[if]="zypper info"
    _pm[in]='sudo zypper install'
    _pm[list]='zypper search'
    _pm[rm]='sudo zypper remove'
    _pm[se]='zypper search'
    _pm[up]='sudo zypper upgrade'
    _pm[ref]='sudo zypper refresh'
elif hash 'pacman' 2>/dev/null; then
    _pm[if]='pacman --sync --info'
    _pm[in]='sudo pacman --sync'
    _pm[list]='pacman --query'
    _pm[rm]='sudo pacman --remove --nosave --recursive --cascade'
    _pm[se]='pacman --sync --search'
    _pm[up]='sudo pacman --sync --sysupgrade'
    _pm[ref]='sudo pacman --sync --refresh'
elif hash 'apt-get' 2>/dev/null; then
    _pm[if]='apt-cache show'
    _pm[in]='sudo apt-get install'
    _pm[list]='dpkg --list'
    _pm[rm]='sudo apt-get purge'
    _pm[se]='apt-cache search'
    _pm[up]='sudo apt-get dist-upgrade'
    _pm[ref]='sudo apt-get update'
fi

# runs command from look-up table
package_manager () {
    if [ ! -n "$1" ]; then
        echo 'Usage: package_manager COMMAND [ARGS]*'
    else
        # looks up arg 1 in LUT, then runs result with remaining args
        ${_pm[${@[1]}]} ${@[@]:2}
    fi
}

alias pm='package_manager'
