### zle-compat

bindkey -e
typeset -g -A key

# compat aliases
# ref: infocmp(1), terminfo(5)
# ref: https://invisible-island.net/ncurses/terminfo.src.html#tic-xterm-256color
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[AltLeft]=${terminfo[kLFT3]}
key[Right]=${terminfo[kcuf1]}
key[AltRight]=${terminfo[kRIT3]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}
key[F1]=${terminfo[kf1]}


# bind keys to zsh's readline replacement
[[ -n "${key[Home]}"     ]] && bindkey "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]] && bindkey "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]] && bindkey "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]] && bindkey "${key[Delete]}"   delete-char

if ! command -v atuin >/dev/null; then
  [[ -n "${key[Up]}"       ]] && bindkey "${key[Up]}"       up-line-or-history
fi

[[ -n "${key[Down]}"     ]] && bindkey "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]] && bindkey "${key[Left]}"     backward-char
[[ -n "${key[AltLeft]}"  ]] && bindkey "${key[AltLeft]}"  emacs-backward-word
[[ -n "${key[Right]}"    ]] && bindkey "${key[Right]}"    forward-char
[[ -n "${key[AltRight]}" ]] && bindkey "${key[AltRight]}" emacs-forward-word


# compatibility for console mode applications
if [[ -n ${terminfo[smkx]} ]] && [[ -n ${terminfo[rmkx]} ]]; then
  zle-line-init   () { echoti smkx; }
  zle-line-finish () { echoti rmkx; }
  zle -N zle-line-init
  zle -N zle-line-finish
fi
