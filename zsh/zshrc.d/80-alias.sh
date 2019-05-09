### alias

setaliases () {

  local color_mode='--color=auto'

  local human_mode='--human'
  local human_mode_gnu='--human-readable'

  # tree
  alias   t='tree -a'
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
  alias rgrep="grep $color_mode_gnu --recursive --ignore-case --exclude-dir=.git"

  # quick and dirty encryption
  alias encrypt='gpg --symmetric --cipher-algo AES256 --armor'
  alias decrypt='gpg --decrypt'

  # misc (coreutils)
  alias df="df $human_mode_gnu"
  alias cp='cp --reflink=auto --sparse=auto'
  alias dd='dd status=progress'

  # misc (systemd)
  alias userctl='systemctl --user --lines 0'
  alias systemctl='systemctl --lines 0'

  # misc (emacs)
  alias vemacs='emacsclient --create-frame --no-wait --alternate-editor=emacs'
  alias emacs='emacsclient --tty --alternate-editor=nano'

  # misc
  alias cert-view='openssl x509 -text -in'
  alias cert-scrape='openssl s_client -showcerts -prexit -connect </dev/null'
  alias dmesg="dmesg $color_mode $human_mode"
  alias feh='feh --no-fehbg --image-bg black --conversion-timeout 1 --draw-filename --draw-exif'
  alias free="free $human_mode"
  alias mutt=neomutt
  alias nmtui='nmtui connect'
  alias torcurl='curl -x socks5h://localhost:9050'

  # display dependent
  if [ -n "$DISPLAY" ]; then
    alias mpv='mpv --wid=${WINDOWID}'
    alias lock='i3lock --show-failed-attempts --color=000000'
  else
    alias mpv='mpv --gpu-context=drm'
    alias lock='vlock -a'
  fi
}
setaliases
