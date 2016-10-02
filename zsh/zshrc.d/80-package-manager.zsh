### package-manager.sh
###
### provides high-level package management by wrapping
### the platform's package manager

declare -A _pm

## populate look-up table
if hash 'zypper' 2>/dev/null; then
    _pm[show]="zypper info"
    _pm[install]='sudo zypper install'
    _pm[list]='zypper search'
    _pm[remove]='sudo zypper remove'
    _pm[search]='zypper search'
    _pm[upgrade]='sudo zypper upgrade'
elif hash 'pacman' 2>/dev/null; then
    _pm[show]='pacman --query --info'
    _pm[install]='sudo pacman --sync'
    _pm[list]='pacman --query'
    _pm[remove]='sudo pacman --remove --nosave --recursive --cascade'
    _pm[search]='pacman --query --search'
    _pm[upgrade]='sudo pacman --sync --refresh --sysupgrade'
elif hash 'apt-get' 2>/dev/null; then
    _pm[show]='apt-cache show'
    _pm[install]='sudo apt-get install'
    _pm[list]='dpkg --list'
    _pm[remove]='sudo apt-get purge'
    _pm[search]='apt-cache search'
    _pm[upgrade]='sudo apt-get dist-upgrade'
fi

## add shortended aliases
# XXX: This assumes uniqueness of 2-character prefixes.
#      Later ones (in the iterator) will override earlier ones.
for i in "${(@k)_pm}"; do
    _pm[${i:0:2}]="${_pm[$i]}"
done

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
