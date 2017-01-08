### alias.zshrc

setaliases () {

  local color_mode='--color=auto'

  local human_mode='--human'
  local human_mode_gnu='--human-readable'

  # tree
  alias   t='tree'
  alias  tt='tree -d'
  alias ttt='tree -dL 2'

  # ls
  local ls_opts="$color_mode $human_mode_gnu \
--classify --group-directories-first --dereference-command-line --time-style='+%y-%m-%d %R'"

  alias  ls="ls $ls_opts"
  alias  ll="ls $ls_opts -l"
  alias lll="ls $ls_opts -l *"
  alias  la="ls $ls_opts    --almost-all"
  alias lla="ls $ls_opts -l --almost-all"

  # cd
  alias ..='cd ..'
  alias ...='cd ../..'
  alias ....='cd ../../..'

  # grep
  alias grep="grep $color_mode_gnu --ignore-case"
  alias egrep="grep $color_mode_gnu --perl-regexp"
  alias rgrep="grep $color_mode_gnu --recursive --ignore-case"

  # misc (coreutils)
  alias df="df $human_mode_gnu"

  # misc
  alias dmesg="dmesg $color_mode $human_mode"
  alias feh='feh --no-fehbg --magick-timeout 1'
  alias free="free $human_mode"
  alias userctl='systemctl --user'
  alias where='whereis -b'

  # display dependent
  if [ -n "$DISPLAY" ]; then
    alias emacs='emacsclient --create-frame --no-wait --alternate-editor=emacs'
    alias mpv='mpv --wid=${WINDOWID}'
    alias lock='i3lock --show-failed-attempts --color=000000'
  else
    alias emacs='emacsclient --tty --alternate-editor=nano'
    alias mpv='mpv --vo=drm'
    alias lock='vlock -a'
  fi
}
setaliases

