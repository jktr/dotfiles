### keybinds.zshrc

user-kill-word-first () {
    zle beginning-of-line
    zle kill-word
}
zle -N user-kill-word-first
bindkey '^[w' user-kill-word-first
