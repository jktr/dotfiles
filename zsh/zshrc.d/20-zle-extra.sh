# alt-backspace to kill backwards to the next '/'
backward-kill-dir () {
    local WORDCHARS=''${WORDCHARS/\/}
    zle backward-kill-word
}
zle -N backward-kill-dir
bindkey '^[^?' backward-kill-dir

# run help for current program on F1 press
autoload -Uz run-help
#autoload -Uz run-help-sudo
#autoload -Uz run-help-git
[[ -n "${key[F1]}" ]] && bindkey "${key[F1]}" run-help
