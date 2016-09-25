### alias.zshrc

setaliases () {

  local color_mode='--color=auto'

  local human_mode='--human'
  local human_mode_gnu='--human-readable'

  # tree
  alias t='tree'
  alias d='tree -d'

  # ls
  local ls_opts="$color_mode $human_mode_gnu \
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
  alias feh='feh --magick-timeout 1'
  alias free="free $human_mode"
  alias i3lock='i3lock --show-failed-attempts --color=000000'
  alias userctl='systemctl --user'
  alias where='whereis -b'
}
setaliases

