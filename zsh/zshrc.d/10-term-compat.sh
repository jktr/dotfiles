autoload -Uz add-zsh-hook

# use OSC 7 to tell terminal about the current directory
_osc7_cwd() {
  local urlencode
  urlencode () {
    local length="${#1}"
    for (( i = 0; i < length; i++ )); do
      local c="${1:$i:1}"
      case $c in
        %) printf '%02X' "$c" ;;
        *) printf "%s" "$c" ;;
      esac
    done
  }
  echo -ne "\e]7;file://$(urlencode "$PWD")\e"
}
add-zsh-hook -Uz chpwd _osc7_cwd


# use OSC 2 to tell terminal about the currently running app
_osc2_cmd() {
  echo -ne "\e]2;${2:-${0:t}}\a"
}


# reset cursor style if apps leave it in a wonky state
_Se_cmd() {
  [[ -n $terminfo[Se] ]] && echoti Se 2
}

add-zsh-hook -Uz preexec _osc2_cmd
add-zsh-hook -Uz precmd  _osc2_cmd
add-zsh-hook -Uz precmd  _Se_cmd
