### prompt

# parameter expansion, command substitution, and arithmetic expansion
# Does not affect command status.
setopt PROMPT_SUBST

# preserve partial lines
setopt PROMPT_SP

_prompt_nix_flake () {

  # this doesn't change during a shell, so use cached value
  if [ -n "$_prompt_nix_flake_cache" ] \
    && [ "$_prompt_nix_flake_cache" != 'none' ]; then
    echo "$_prompt_nix_flake_cache"
    return
  fi

  local name="$(ps --no-header -o comm:1 $$)"
  local -r curr="$name"
  local ppid="$$"

  # walk tree up until first non-shell parent
  while true; do
    ppid="$(ps --no-header -o ppid:1 "$ppid")"
    name="$(ps --no-header -o comm:1 "$ppid")"
    [ -n "$name" -a "$name" = "$curr" ] || break
  done

  ## FIXME
  if ! [ -r /proc/${ppid}/environ ]; then
    _prompt_nix_flake_cache='none'
    return
  fi

  # check if we're running directly under something like sudo
  if ! [ -r /proc/${ppid}/environ ]; then
    _prompt_nix_flake_cache='none'
    return
  fi

  # check for differences in PATH to us
  local -r pstore="$(grep --null-data --basic-regexp '^PATH=' \
    < "/proc/${ppid}/environ" \
    |cut --zero-terminated -d= -f2- \
    |tr '\0:' '\n\n' \
    |grep --basic-regexp '^/nix/store/')"

  local -r cstore="$(<<< "$PATH" cut -d= -f2- \
    |tr ':' '\n' \
    |grep --basic-regexp '^/nix/store/')"

  local -r additions="$(comm -13 \
    <(sort <<< "$pstore") <(sort <<< "$cstore") \
    |cut -d- -f2|paste -sd:)"

  if [ -z "$additions" ]; then
    _prompt_nix_flake_cache='none'
    return
  fi

  _prompt_nix_flake_cache=" %F{yellow}${additions}"
  echo "$_prompt_nix_flake_cache"
}
_prompt_nix_flake >/dev/null # initialize the cache



_prompt_nix () {
  case "${IN_NIX_SHELL}" in
    pure)   local -r color='%F{green}'  ;;
    impure) local -r color='%F{yellow}' ;;
    '')   return ;;
    *)    local -r color="%F{red}"  ;;
  esac
  local -r inputs="$(<<<"${buildInputs} ${nativeBuildInputs}" \
    tr ' ' '\n'|awk NF|cut -d- -f2|sort -u|paste -sd:)"
  echo " ${color}${inputs}"
}

# "branch@commit" if inside git repo
#
#   branch
#   red  - diverged from origin
#   yellow - ahead or behind of origin
#   green  - up to date with origin
#   cyan   - no remote exists
#   commit-sha
#   red  - only unstaged changes present
#   yellow - some/all changes staged
#   green  - default
#   cyan   - this is a bare repo
_prompt_git () {
  local dot_git="$(git rev-parse --git-dir 2>/dev/null)"
  [ -n "$dot_git" ] || return # not a git dir

  #! XXX: using this here is ~3x faster than `git name-rev --name-only HEAD`
  local ref="${$(git rev-parse --symbolic-full-name HEAD 2>/dev/null)#refs/heads/}"
  local sha

  if [ "$ref" = 'HEAD' ]; then # no initial commit yet
    sha='%F{cyan}initial%f'
    if git rev-parse '@{upstream}' &>/dev/null; then
      ref='%F{green}main%f'
    else
      ref='%F{cyan}main%f'
    fi
  else
    # set HEAD's SHA according to staging area's status
    sha="$(git rev-parse --short HEAD 2>/dev/null)"

    if "$(git rev-parse --is-bare-repository)" -eq 'true'; then
      sha="%F{cyan}${sha}%f"
    elif ! git diff-index --quiet --ignore-submodules --cached HEAD; then
      sha="%F{yellow}${sha}%f"
    elif ! git -C "$dot_git/.." diff-index --quiet --ignore-submodules HEAD; then
      sha="%F{red}${sha}%f"
    else
      sha="%F{green}${sha}%f"
    fi

    # set branch status according to (possibly missing) upstream
    # this only uses local tracking information
    if ! git rev-parse '@{upstream}' &>/dev/null; then
      ref="%F{cyan}${ref}%f"
    else
      local -r n_ahead="$(git rev-list --count @{upstream}..HEAD)"
      local -r n_behind="$(git rev-list --count HEAD..@{upstream})"

      if [ $n_ahead -eq 0 ]; then
        if [ $n_behind -eq 0 ]; then
          ref="%F{green}${ref}%f"
        else
          ref="%F{yellow}${ref}-${n_behind}%f"
        fi
      else
        if [ $n_behind -eq 0 ]; then
          ref="%F{yellow}${ref}+${n_ahead}%f"
        else
          ref="%F{red}${ref}+${n_ahead}-${n_behind}%f"
        fi
      fi
    fi
  fi

  echo " ${ref} ${sha}"
}


## prompt proper

setprompt () {

  # username & prompt sym
  #  red  - root
  #  yellow - capabilities are set
  #  green  - default
  local -r username='%F{%(0#.red.%(!.yellow.green))}%n%f'
  local -r prompt_sym='%F{%(!.red.green)}%#%f'

  # host
  #  yellow - remote over ssh
  #  green  - default
  if [ -n "$SSH_CLIENT" -o \
     -n "$SSH2_CLIENT" -o \
     -n "$SSH_TTY" ]; then
    local -r host='%F{yellow}%m%f'
  else
    local -r host='%F{green}%m%f'
  fi

  # path
  local -r pwd='%F{green}%~%f'

  # exit status (if nonzero)
  local -r nonzero_exit_p="%(0?..%F{red}%?%f )"
  # bg jobs (if any)
  local -r jobs_p="%(1j.%F{cyan}%j%f .)"

  # HH:MM:SS timestamp
  local -r timestamp="%F{green}%D{%T}%f"

  PS1="  ${username} ${host}\$(_prompt_git)\$(_prompt_nix_flake) ${pwd}
${prompt_sym} "

  PS2="%F{green}%_%f ${prompt_sym}"

  RPROMPT="${nonzero_exit_p}${jobs_p}${timestamp}"
}
setprompt
unset -f setprompt
