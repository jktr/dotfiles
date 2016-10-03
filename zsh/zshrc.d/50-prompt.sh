### prompt.zshrc

# parameter expansion, command substitution and arithmetic expansion
# does not affect command status. 
setopt PROMPT_SUBST

# preserve partial lines
setopt PROMPT_SP

# prompt component separator
# placed here as it may be needed by shell functions
readonly _i='%F{blue}|%f'
readonly _i_soft='%F{blue}@%f'


# branch@commit if inside git repo
#
#   branch
#     red    - diverged from origin
#     yellow - ahead or behind of origin
#     green  - up to date with origin
#   commit-sha
#     red    - only unstaged changes present
#     yellow - some/all changes staged
#     green  - default
_prompt_git ()
{
    if [ -n "$(git rev-parse --git-dir 2>/dev/null)" ]; then

        #! XXX: using this here is ~3x faster than `git name-rev --name-only HEAD`
        local ref="${$(git rev-parse --symbolic-full-name HEAD 2>/dev/null)#refs/heads/}"
        local sha

        # check if HEAD does not exist yet
        if [ "$ref" = 'HEAD' ]; then # if true, then HEAD does NOT exist
            sha='%F{green}initial%f' # instead of not-yet-existing HEAD's SHA
            ref='%F{green}master%f'
        else

            # set HEAD's SHA according to staging area's status
            sha="$(git rev-parse --short HEAD 2>/dev/null)"
            if   ! git diff-index --quiet --ignore-submodules --cached HEAD; then
                sha="%F{yellow}${sha}%f"
            elif ! git diff-index --quiet --ignore-submodules HEAD; then
                sha="%F{red}${sha}%f"
            else
                sha="%F{green}${sha}%f"
            fi

            # set branch status according to (possibly missing) upstream
            if ! git rev-parse '@{upstream}' &>/dev/null; then
                ref="%F{green}${ref}%f"
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
    fi
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

    #    local tty='%F{green}%y%f'
    #    local history_id='%F{green}%!%f'
    local -r pwd='%F{green}%~%f'
    local -r timestamp='%F{green}%D{%H:%M:%S}%f'

    # exit status only if nonzero
    local -r nonzero_exit_p="%(0?..%F{red}%?%f${_i})"
    # exit status only if nonzero
    local -r jobs_p="%(1j.%F{cyan}%j%f${_i}.)"

    PS1="${p}${username}${_i_soft}${host}\$(_prompt_git)${_i}${pwd}${s}
${prompt_sym} "

    PS2="%F{green}%_%f${_i}${prompt_sym}"

    RPROMPT="${p}${nonzero_exit_p}${jobs_p}${timestamp}${s}"
}
setprompt