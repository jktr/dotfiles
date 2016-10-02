### keybinds.zshrc

user-kill-word-first () {
    zle beginning-of-line
    zle kill-word
}
zle -N user-kill-word-first
bindkey '^[w' user-kill-word-first

user-prepend () {
    read -k str
    case "${str}" in
    s) str='sudo ' ;;
    m) str='man '  ;;
    e) str='$EDITOR ' ;;
    *) return 0 ;;
    esac
    zle beginning-of-line
    zle -U ${str}
}
zle -N user-prepend
bindkey '^[e' user-prepend

user-append () {
    read -k str
    case "${str}" in
    l) str=' | less' ;;
    *) return 0 ;;
    esac
    zle end-of-line
    zle -U ${str}
}
zle -N user-append
bindkey '^[r' user-append

