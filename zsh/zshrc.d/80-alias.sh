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
--classify --group-directories-first \
--time-style='+%y-%m-%d %R'"

  alias  ls="ls $ls_opts --ignore-backups"
  alias  ll="ls $ls_opts -l --ignore-backups"
  alias lll="ls $ls_opts -l --ignore-backups *"
  alias  la="ls $ls_opts    --almost-all"
  alias lla="ls $ls_opts -l --almost-all"

  # cd
  alias ..='cd ..'
  alias ...='cd ../..'
  alias ....='cd ../../..'
  alias //='cd -'

  # grep
  alias grep="grep $color_mode --ignore-case"
  alias egrep="grep $color_mode --perl-regexp"
  alias rg='rg --smart-case'
  alias rgrep='rg --smart-case'

  # quick and dirty encryption
  alias encrypt='gpg --symmetric --cipher-algo AES256 --armor --no-symkey-cache'
  alias decrypt='gpg --decrypt'

  # coreutils
  alias df="df $human_mode_gnu"
  alias cp='cp --reflink=auto --sparse=auto'
  alias dd='dd status=progress conv=fsync'
  alias rm='rm --interactive=once --dir'

  # systemd
  alias userctl='systemctl --user --lines 0'
  alias systemctl='systemctl --lines 0'

  # ffmpeg
  alias ffmpeg='ffmpeg -hide_banner'
  alias ffprobe='ffprobe -hide_banner'
  alias ffplay='ffplay -hide_banner'

  # nixos
  alias nix-shell='nix-shell --command "exec zsh"'
  alias nix='nix --print-build-logs'

  # mqtt
  alias msub='mosquitto_sub -h mqtt'
  alias mpub='mosquitto_pub -h mqtt'

  # openssl
  alias cert-view='openssl x509 -text -in'
  alias cert-scrape='openssl s_client -showcerts -prexit -connect </dev/null'

  # misc
  alias cal='task calendar'
  alias diff='git diff --no-index --exit-code'
  alias dmesg="dmesg $color_mode $human_mode"
  alias env='env|sort'
  alias feh='feh --no-fehbg --image-bg black --conversion-timeout 1 --draw-filename --draw-exif --draw-actions --scale-down'
  alias foot='footclient'
  alias free="free $human_mode"
  alias fzf='fzf --cycle --multi'
  alias hist="sort|uniq --count|sort --numeric-sort|tail -n40"
  alias icat='kitty +kitten icat'
  alias ip="ip $color_mode"
  alias mixxx='mixxx -platform xcb'
  alias nano="$EDITOR"
  alias nmtui='nmtui connect'
  alias ss='ss --numeric'
  alias token='command dd if=/dev/urandom bs=32 count=1 status=none|sha256sum|cut -d" " -f1'
  alias torcurl='curl --proxy socks5h://localhost:9050'

  # display dependent
  if [ -n "$DISPLAY" ]; then
    alias    mpv='mpv --gpu-context=wayland'
    alias webcam='mpv --gpu-context=wayland --profile=low-latency --untimed av://v4l2:/dev/video0'
    alias lock=swaylock
  else
    alias    mpv='mpv --gpu-context=drm'
    alias webcam='mpv --gpu-context=drm --profile=low-latency --untimed av://v4l2:/dev/video0'
    alias lock='vlock -a'
  fi
}
setaliases
