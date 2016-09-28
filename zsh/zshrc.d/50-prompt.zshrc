### prompt.zshrc

# parameter expansion, command substitution and arithmetic expansion
# does not affect command status. 
setopt PROMPT_SUBST

# preserve partial lines
setopt PROMPT_SP

# prompt component separator
# placed here as it may be needed by shell functions
_i='%F{blue}|%f'
_i_soft='%F{blue}@%f'

# branch@commit if inside git repo
_prompt_git ()
{
    #! XXX: using this here is ~3x faster than `git ame-rev --name-only HEAD`
    local ref="${$(git rev-parse --symbolic-full-name HEAD 2> /dev/null)#refs/heads/}"
    if [ -n "$ref" ]; then

        # branch
        #   red    - diverged from origin
        #   yellow - ahead or behind of origin
        #   green  - up to date with origin
        if ! git rev-parse '@{upstream}' &> /dev/null; then # if no upstream exists
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

        local sha="$(git rev-parse --short HEAD 2> /dev/null)"
        
        # commit
        #   red    - only unstaged changes present
        #   yellow - some/all changes staged
        #   green  - default
        if ! git diff-index --quiet --ignore-submodules --cached HEAD; then
            sha="%F{yellow}${sha}%f"
        elif ! git diff-index --quiet --ignore-submodules HEAD; then
            sha="%F{red}${sha}%f"
        else
            sha="%F{green}${sha}%f"
        fi
        
        echo "${_i}${ref}${_i_soft}${sha}"
    fi
}


## prompt proper

setprompt () {

    # delimiters
    local p='%F{blue}[%f'  # prefix
    local s=$'%F{blue}]%f' # suffix

    # username & prompt sym
    #  red    - root
    #  yellow - capabilities are set
    #  green  - default
    local username='%F{%(0#.red.%(!.yellow.green))}%n%f'
    local prompt_sym='%F{%(!.red.green)}%#%f'

    # host
    #  yellow - remote over ssh
    #  green  - default
    if [ -n "$SSH_CLIENT" -o \
         -n "$SSH2_CLIENT" -o \
         -n "$SSH_TTY" ]; then
        local host='%F{yellow}%m%f'
    else
        local host='%F{green}%m%f'
    fi

    #    local tty='%F{green}%y%f'
    #    local history_id='%F{green}%!%f'
    local pwd='%F{green}%~%f'
    local timestamp='%F{green}%D{%H:%M:%S}%f'

    # exit status only if nonzero
    local nonzero_exit_p="%(0?..%F{red}%?%f${_i})"
    # exit status only if nonzero
    local jobs_p="%(1j.%F{cyan}%j%f${_i}.)"

    PS1="${p}${username}${_i_soft}${host}\$(_prompt_git)${_i}${pwd}${s}
${prompt_sym} "

    PS2="%F{green}%_%f${_i}${prompt_sym}"

    RPROMPT="${p}${nonzero_exit_p}${jobs_p}${timestamp}${s}"
}
setprompt
