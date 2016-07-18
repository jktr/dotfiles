# .zshrc

### misc shopt

setopt shwordsplit
setopt nomatch RM_STAR_WAIT
unsetopt beep
autoload -U colors && colors


### completion

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

# bind keys to zsh's readline replacement
[[ -n "${key[Home]}"     ]] && bindkey "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]] && bindkey "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]] && bindkey "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]] && bindkey "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]] && bindkey "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]] && bindkey "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]] && bindkey "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]] && bindkey "${key[Right]}"    forward-char

# compatibility for console mode applications
if [[ -n ${terminfo[smkx]} ]] && [[ -n ${terminfo[rmkx]} ]]; then
  zle-line-init   () { echoti smkx; }
  zle-line-finish () { echoti rmkx; }
  zle -N zle-line-init
  zle -N zle-line-finish
fi


### key macros

# defin fns
user-kill-word-first () {
    zle beginning-of-line
    zle kill-word
}
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
user-append () {
    read -k str
    case "${str}" in
	l) str=' | less' ;;
	*) return 0 ;;
    esac
    zle end-of-line
    zle -U ${str}
}

# bind to keys
zle -N user-kill-word-first
bindkey '^[w' user-kill-word-first
zle -N user-prepend
bindkey '^[e' user-prepend
zle -N user-append
bindkey '^[r' user-append



### prompt

setopt prompt_subst
setprompt () {

  # expansion seqs
  e_usr='%n'
  e_usrsym='%#'
  e_host='%M'
  e_pwd='%~'
  e_multiline_desc='%_'

  # color aliases
  for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
    eval PR_$color='%{$fg[${(L)color}]%}'
  done

  # color conf
  c_reset="%{$reset_color%}"
  c_delim="${PR_BLUE}"
  c_pwd="${PR_GREEN}"
  c_uid_root="${PR_RED}"
  c_uid_sys="${PR_YELLOW}"
  c_uid_usr="${PR_GREEN}"
  c_host_local="${PR_GREEN}"
  c_host_remote="${PR_YELLOW}"
  c_nzexit="${PR_MAGENTA}"

  # user part, with selective color
  if [[ $UID -eq 0 ]]; then
    c_pr_usr="${c_uid_root}"
    c_pr_usr_sym="${c_uid_root}"
  elif [[ $UID -lt 1000 ]]; then
    c_pr_usr="${c_uid_sys}"
    c_pr_usr_sym="${c_uid_sys}"
  else
    c_pr_usr="${c_uid_usr}"
    c_pr_usr_sym="${c_uid_usr}"
  fi

  # host part, with selective color
  if [[ -n "$SSH_CLIENT" || -n "$SSH2_CLIENT" ]]; then
    c_pr_host="${c_host_remote}"
  else
    c_pr_host="${c_host_local}"
  fi
    
  # actually set prompt
  PS1=$'${c_delim}[${c_pr_usr}${e_usr}${c_delim}@${c_pr_host}${e_host}${c_delim}|${c_pwd}${e_pwd}${c_delim}]${c_pr_usr}${e_usrsym}${c_reset} '
  PS2=$'${e_multiline_desc}>'
  RPROMPT=$'%(?..${c_nzexit}[${c_reset}%?${c_nzexit}]${c_reset})'
}
setprompt


### umask

umask -S u=rwx,g=rx,o=


### history

HISTFILE=~/.zsh_history
HISTSIZE=500
SAVEHIST=100
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS HIST_VERIFY
unsetopt appendhistory


### env-vars

# editor - requires some hacks b/c argument expansion with spaces
mkdir -p "${HOME}/bin"
echo -e '#!/bin/sh\nexec emacsclient --tty --alternate-editor=nano $@'           > ~/bin/EDITOR
echo -e '#!/bin/sh\nexec emacsclient --create-frame --alternate-editor=emacs $@' > ~/bin/VISUAL
chmod u=rwx,g=,o= ~/bin/{EDITOR,VISUAL}


### alias

color_mode='--color=auto'

human_mode='--human'
human_mode_gnu='--human-readable'

# tree
alias t='tree'
alias d='tree -d'

# ls

ls_opts="$color_mode $human_mode_gnu \
--classify --group-directories-first --dereference-command-line --time-style='+%y-%m-%d %R'"

alias  ls="ls $ls_opts"
alias  ll="ls $ls_opts -l"
alias  la="ls $ls_opts    --almost-all"
alias lla="ls $ls_opts -l --almost-all"

# pacman
alias pm='pacman'
alias spm='sudo pacman'

# emacs
alias emacs='emacsclient --tty --alternate-editor=nano'
alias emax='emacsclient --create-frame --no-wait --alternate-editor=emacs'

# cd
alias ..='cd ..'
alias ...='cd ../..'

# misc (coreutils)
alias df="df $human_mode_gnu"
alias grep="grep $color_mode_gnu"

# misc
alias dmesg="dmesg $color_mode $human_mode"
alias free="free $human_mode"
alias i3lock='i3lock --show-failed-attempts --color=000000'
alias userctl='systemctl --user'
alias where='whereis -b'


### useful fns

# prints process environment by pid or process name
envof () {
  case $1 in
    ''|'-h'|'--help') # no args or help request
      echo "Usage: envof (pid|progname)"
      ;;
    *[!0-9]*) # string has at least one non-numeric char
      for pid in $(pidof $1); do
        echo "----------- $pid -----------"
        xargs --null --max-args=1 < "/proc/$pid/environ"
      done
      ;;
    *) # args has only numeric chars
      xargs --null --max-args=1 < "/proc/$1/environ"
      ;;
  esac
}

# prints largest directories by size on disk
heavy () {
  if [ -d "$1" ]; then
    du --max-depth=1 -h "$1" | sort -hr
  else
    du --max-depth=1 -h "${PWD}" | sort -hr
  fi
}

