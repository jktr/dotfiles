### fn-misc

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
        echo "$f"
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
    local -r pastebin='https://0x0.st'

    if [ "$1" = '--sign' ]; then
        local -r filter='gpg --clearsign --output -'
        shift
    else
        local -r filter='cat'
    fi

    if [ -n "$1" ]; then
        local -r file="$1"
    else
        local -r file='-'
    fi

    $filter "$file" | curl -F'file=@-' "$pastebin"
}
