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
  alias //='cd -'

  # grep
  alias grep="grep $color_mode_gnu --ignore-case"
  alias egrep="grep $color_mode_gnu --perl-regexp"
  alias rgrep="grep $color_mode_gnu --recursive --ignore-case"

  # quick and dirty encryption (please use gpg instead…)
  alias encrypt='openssl enc -aes-256-cbc -base64 -in'
  alias decrypt='openssl enc -d -aes-256-cbc -a -in'

  # misc (coreutils)
  alias df="df $human_mode_gnu"
  alias cp='cp --reflink=auto'

  # misc
  alias dmesg="dmesg $color_mode $human_mode"
  alias feh='feh --no-fehbg --image-bg black --magick-timeout 1 --draw-filename --draw-exif'
  alias free="free $human_mode"
  alias userctl='systemctl --user'
  alias where='whereis -b'
  alias certview='openssl x509 -text -in'

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

