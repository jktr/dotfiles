### fn-misc

# looks up args via duckduckgo
w3d () {
    local -r params="$*"
    w3m 'https://duckduckgo.com/?q='"${params//\ /+}" 
}

# looks up args via duck duck go, using $1 as bang
w3b () {
    local -r params="$*"
    w3m 'https://duckduckgo.com/?q='!"${params//\ /+}"
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

# submit file/stdin to pastebin, optionally signing it
pastebin () {
    local -r pastebin='https://0x0.st'

    if [ "$1" = '--sign' ]; then
        local -r filter='gpg --clearsign --output -'
        shift
    else
        local -r filter='cat'
    fi

    if [ -n "$1" ]; then
        local -r file="$1"
    else
        local -r file='-'
    fi

    $filter "$file" | curl -F'file=@-' "$pastebin"
}
