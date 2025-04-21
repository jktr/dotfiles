### fn-misc

tmp () (
  readonly tmpdir=$(mktemp -d ${1:-})
  [[ -z $tmpdir ]] && exit 1
  TRAPEXIT() {
    rm -rf $tmpdir
  }
  cd $tmpdir
  zsh -is
)

# fuzzy movement and execution via fzf
ff () {
    unset f
    f="$(fzf --cycle --multi)" # mutable, not local
    [ -n "$f" ] || return
    [ $(wc -l <<< "$f") -eq 1 ] && cd "$(dirname "$f")"
    if [ $# -ne 0 ]; then
        cd -
        eval "$@ $(tr '\n' ' ' <<< "$f")"
    else
        [ $(wc -l <<< "$f") -ne 1 ] && return
        echo "\$f = $f"
    fi
}

cd () {
  if [ $# != 1 ] || [ "$1" = - ] || [ -z "$1" ] || [ -d "$1" ]; then
    # normal cd
    builtin cd "$@"
  elif command -v "$1" >/dev/null; then
    # resolve commands and cd to the directory that contains them
    alias "$1" >/dev/null && unalias "$1"
    local p="$(dirname "$(realpath "$(command -v "$1")")")"
    # for nix store paths, go to derivation root instead of the bin directory
    [[ "$p" =~ /nix/store/ ]] && p="$(cut -d "/" -f-4 <<< "$p")"
    builtin cd "$p"
  elif [ -e "$1" ]; then
    builtin cd "$(dirname "$@")"
  else
    builtin cd "$@"
  fi
}

spectrogram () {
  local -r f=/tmp/spectrum.jpg
  echo $f
  ffmpeg -y -loglevel error -i "$1" -lavfi showspectrumpic "$f" && feh "$f"
}

# gets weather forecast
wttr () {
    curl "https://wttr.in/$@" 2>/dev/null | $PAGER -r
}

# print colors w/ escape codes
swath () {
    for x in {0..8}; do
        for i in {30..37}; do
            for a in {40..47}; do
                echo -ne "\e[$x;$i;$a""m\\\e[$x;$i;$a""m\e[0;37;40m "
            done
            echo
        done
    done
}

# submit file/stdin to pastebin, optionally signing it
pastebin () {
    local -r pastebin="${PASTEBIN:-https://0x0.st}"

    if [ "$1" = '--sign' ]; then
        local -r filter='gpg --clearsign --output -'
        shift
    fi

    [ -n "$1" ] && local -r file="$1"

    if [ -n "${filter:-}" ]; then
      $filter "${file:--}" |curl -F "file=@-" "$pastebin"
    else
      curl -F "file=@${file:--}" "$pastebin"
    fi
}
