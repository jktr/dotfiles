### fn-misc

# generates new ssh key
# $1 destination
# $2 identity
# $3 link as
ssh-keygen () {
    [ -n "$1" ] || { echo must provide destination && return 1; }
    [ -n "$2" ] || { echo must provide identity && return 1; }
    local -r key=~/.ssh/keys/"id_$(date +%Y-%m-%d)_ed25519_$1-$2"
    local -r pub="${key}.pub"
    command ssh-keygen -t ed25519 -f "$key" -C "$HOST::$1::$2"
    [ -n "$3" ] && {
        ln -sf ${key} ~/.ssh/keys/"${3}.key"
        local -r conf=~/.ssh/config.d/"${3}.conf"
        [ -e "$conf" ] || cat > "${conf}" <<EOF
Host ${3}

    User $2
    Port 22
EOF
    }
}

# looks up args via duck duck go
w3d () {
    local -r params="$*"
    w3m 'https://duckduckgo.com/?q='"${params//\ /+}" 
}

# sets up tty color and layout
ttyinit () {
    setvtrgb ${XDG_CONFIG_HOME}/tty/colormap
    reset
    sudo loadkeys ${XDG_CONFIG_HOME}/tty/keymap
}

# gets weather forecast
wttr () {
    curl "https://wttr.in/$@" 2>/dev/null | $PAGER -r
}

# print colors w/ escape codes
colortest () {
    for x in {0..8}; do
        for i in {30..37}; do
            for a in {40..47}; do
                echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
            done
            echo
        done
    done
}
