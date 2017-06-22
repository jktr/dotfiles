### fn-misc

# generates new ssh key
ssh-keygen () {
    command ssh-keygen -t ed25519 \
                       -f "~/.ssh/keys/id_ed25519_$1_$(date +%Y-%m-%d)" \
                       -C "$HOST::$1::$2"
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
