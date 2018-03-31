### fn-misc

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
