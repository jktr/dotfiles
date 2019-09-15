### completion

zstyle ':completion:*' completer _extensions _complete _list _approximate

zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' group-name '%d'
zstyle ':completion:*' ignore-parents pwd ..
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' menu select=long
zstyle ':completion:*' use-compctl false

autoload -Uz compinit && compinit -d "$XDG_CACHE_HOME/zcompdump"
