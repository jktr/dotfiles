### prompt

# parameter expansion, command substitution and arithmetic expansion
# does not affect command status.
setopt PROMPT_SUBST

# preserve partial lines
setopt PROMPT_SP

# prompt component separator
# placed here as it may be needed by shell functions
readonly _i='%F{blue}|%f'
readonly _i_soft='%F{blue}@%f'

_prompt_nix () {
    if [ -n "${IN_NIX_SHELL}" ]; then
        local -r inputs="$(<<<"${buildInputs}" tr ' ' '\n'|cut -d '-' -f2|grep -v zsh|sort|paste -sd:)"
        case "${IN_NIX_SHELL}" in
            pure)   local -r nix="%F{green}${inputs}" ;;
            impure) local -r nix="%F{yellow}${inputs}" ;;
#            *)      local -r nix="%F{red}${inputs}" ;;
        esac
        echo "${_i}${nix}"
    fi
}


# "branch@commit" if inside git repo
#
#   branch
#     red    - diverged from origin
#     yellow - ahead or behind of origin
#     green  - up to date with origin
#     cyan   - no remote exists
#   commit-sha
#     red    - only unstaged changes present
#     yellow - some/all changes staged
#     green  - default
#     cyan   - this is a bare repo
_prompt_git () {
    local dot_git="$(git rev-parse --git-dir 2>/dev/null)"
    if [ -z "$dot_git" ]; then
        return # not a git dir
    fi

    #! XXX: using this here is ~3x faster than `git name-rev --name-only HEAD`
    local ref="${$(git rev-parse --symbolic-full-name HEAD 2>/dev/null)#refs/heads/}"
    local sha

    if [ "$ref" = 'HEAD' ]; then # no initial commit yet
        sha='%F{cyan}initial%f'
        if git rev-parse '@{upstream}' &>/dev/null; then
            ref='%F{green}master%f'
        else
            ref='%F{cyan}master%f'
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
            local n_ahead="$(git rev-list --count @{upstream}..HEAD)"
            local n_behind="$(git rev-list --count HEAD..@{upstream})"

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

    echo "${_i}${ref}${_i_soft}${sha}"
}


## prompt proper

setprompt () {

    # delimiters
    local -r p='%F{blue}[%f'  # prefix
    local -r s=$'%F{blue}]%f' # suffix

    # username & prompt sym
    #  red    - root
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

    #local history_id='%F{green}%!%f'

    # exit status (if nonzero)
    local -r nonzero_exit_p="%(0?..%F{red}%?%f${_i})"
    # bg jobs (if any)
    local -r jobs_p="%(1j.%F{cyan}%j%f${_i}.)"

    # HH:MM:SS timestamp
    local -r timestamp="%F{green}%D{%T}%f"

    PS1="${p}${username}${_i_soft}${host}\$(_prompt_nix)\$(_prompt_git)${_i}${pwd}${s}
${prompt_sym} "

    PS2="%F{green}%_%f${_i}${prompt_sym}"

    RPROMPT="${p}${nonzero_exit_p}${jobs_p}${timestamp}${s}"
}
setprompt
