### fn-misc

# run command when file was potentially changed
on-changed () {
  inotifywait --quiet --monitor -e close_write "$1" \
    | while read -r filename event; do
      ${@:2}
  done
}

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

# init new project
new () {
  mkdir -p "$@"
  cd "$@"
  [ -d .git ] && return
  echo "# $@" > README.md
  touch .gitignore
  git init --quiet
  git a README.md .gitignore
  git commit --quiet -m 'initial commit'
}

cd () {
  if [ "$1" = - ] || [ -z "$1" ] || [ -d "$1" ]; then
    # normal cd
    builtin cd "$@"
  elif command -v "$1" >/dev/null; then
    # resolve commands and cd to the directory that contains them
    local p="$(dirname "$(realpath "$(command -v "$1")")")"
    # for nix store paths, go to derivation root instead of the bin directory
    [[ "$p" =~ /nix/store/ ]] && p="$(cut -d "/" -f-4 <<< "$p")"
    builtin cd "$p"
  else
    builtin cd "$(dirname "$@")"
  fi
}

# looks up args via duckduckgo
w3d () {
    local -r params="$*"
    w3m 'https://duckduckgo.com/?q='"${params//\ /+}" 
}

# looks up args via duckduckgo, using $1 as bang
w3b () {
    local -r params="$*"
    w3m 'https://duckduckgo.com/?q='!"${params//\ /+}"
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
    local -r pastebin='${PASTEBIN:-https://0x0.st}"

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
