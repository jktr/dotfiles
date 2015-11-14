### umask
umask -S u=rwx,g=rx,o=


### shopt misc
setopt nomatch RM_STAR_WAIT
unsetopt beep


### comp
zstyle ':completion:*' completer _complete _ignored
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' group-name '%d'
zstyle ':completion:*' ignore-parents pwd
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=* r:|=*' ''
zstyle ':completion:*' menu select=long
zstyle ':completion:*' original false
zstyle ':completion:*' verbose true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle :compinstall filename '/home/jktr/.zshrc'
autoload -Uz compinit && compinit


### history
HISTFILE=~/.zsh_history
HISTSIZE=500
SAVEHIST=100
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS HIST_VERIFY 
unsetopt appendhistory


### vars
# apps
export EDITOR='nano'
export PAGER='less'
export TERMINAL='urxvtc'
export BROWSER='firefox'
# path
export PATH="${PATH}:${HOME}/bin:${HOME}/develop/bin:${HOME}/games/bin"
# locale
export LANG=en_US.UTF-8
export LC_MESSAGES=C # unexpected, non-universal translations make for bad UX
# env
export RXVT_SOCKET="/run/user/${UID}/urxvtd-${HOST}"

### keys
bindkey -e
typeset -g -A key
# compat aliases
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}
# setup keys
[[ -n "${key[Home]}"     ]] && bindkey "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]] && bindkey "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]] && bindkey "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]] && bindkey "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]] && bindkey "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]] && bindkey "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]] && bindkey "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]] && bindkey "${key[Right]}"    forward-char
# console application mode compat
if [[ -n ${terminfo[smkx]} ]] && [[ -n ${terminfo[rmkx]} ]]; then
  zle-line-init   () { echoti smkx; }
  zle-line-finish () { echoti rmkx; }
  zle -N zle-line-init
  zle -N zle-line-finish
fi


### key macros
# macros
user-kill-word-first () {
    zle beginning-of-line
    zle kill-word
}
user-prepend () {
    read -k str
    case "${str}" in
	s) str='sudo ' ;;
	m) str='man '  ;;
	e) str='nano ' ;;
	*) return 0 ;;
    esac
    zle beginning-of-line
    zle -U ${str}
}
user-append () {
    read -k str
    case "${str}" in
	l) str=' | less' ;;
	*) return 0 ;;
    esac
    zle end-of-line
    zle -U ${str}
}
zle -N user-kill-word-first
bindkey '^[w' user-kill-word-first
zle -N user-prepend
bindkey '^[e' user-prepend
zle -N user-append
bindkey '^[r' user-append


### color
autoload -U colors && colors
color_mode='--color=always'
# base utils
alias ls="ls -F $color_mode"
alias grep="grep $color_mode"
alias dmesg="dmesg $color_mode"
# others
alias pacman='pacman --color always '


### prompt
setopt prompt_subst
setprompt () {
    # color aliases
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$fg[${(L)color}]%}'
    done
    PR_NONE="%{$reset_color%}"

    # conf
    PR_C_STATIC="${PR_BLUE}"
    PR_C_PWD="${PR_GREEN}"
    PR_C_USER="${PR_GREEN}"
    PR_C_ROOT="${PR_RED}"
    PR_C_LOCAL="${PR_GREEN}"
    PR_C_REMOTE="${PR_YELLOW}"
    PR_C_NZEXIT="${PR_MAGENTA}"

    # user part, with selective color
    if [[ $UID -ge 1000 ]]; then
	eval PR_USER='${PR_C_USER}%n'
	eval PR_USER_OP='${PR_C_USER}%#'
    elif [[ $UID -eq 0 ]]; then
	eval PR_USER='${PR_C_ROOT}%n'
	eval PR_USER_OP='${PR_C_ROOT}%#'
    fi

    # host part, with selective color
    if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
	eval PR_HOST='${PR_C_REMOTE}%M'
    else
	eval PR_HOST='${PR_C_LOCAL}%M'
    fi
    
    # actually set prompt
    PS1=$'${PR_C_STATIC}[${PR_USER}${PR_C_STATIC}@${PR_HOST}${PR_C_STATIC}][${PR_C_PWD}%~${PR_C_STATIC}]${PR_USER_OP}${PR_WHITE}${PR_NONE} '
    PS2=$'%_>'
    RPROMPT=$'%(?..${PR_C_NZEXIT}[${PR_NONE}%?${PR_C_NZEXIT}]${PR_NONE})'
}
setprompt


### functions
heavy () {
    if [ -d "$1" ]; then
	du --max-depth=1 -h "$1" | sort -hr
    else
	du --max-depth=1 -h "${PWD}" | sort -hr
    fi
}


### alias
# ls
alias ll='ls -lh '
alias la='ls -a '
alias lla='ls -alh '
# pacman
alias pm='pacman '
alias spm='sudo pacman '
# misc
alias less='less -r ' # special seqs; for color
alias i3lock='i3lock --show-failed-attempts --color=000000 '
