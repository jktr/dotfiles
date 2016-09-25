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
    local sha="$(command git rev-parse --short HEAD 2> /dev/null)"
    if [ -n "$sha" ]; then
        local ref="$(command git symbolic-ref --quiet HEAD 2> /dev/null)"

        if ! git show-ref origin/${ref#refs/heads/} &> /dev/null; then
            # if no remote exists
            ref="%F{green}${ref#refs/heads/}%f"
        else
            # branch
            #   red    - diverged from origin
            #   yellow - ahead or behind of origin
            #   green  - up to date with origin
            local ahead=$(git rev-list --count @{upstream}..HEAD)
            local behind=$(git rev-list --count HEAD..@{upstream})
            if [ $ahead -eq 0 ]; then
                if [ $behind -eq 0 ]; then
                    ref="%F{green}${ref#refs/heads/}%f"
                else
                    ref="%F{yellow}${ref#refs/heads/}-${behind}%f"
                fi
            else
                if [ $behind -eq 0 ]; then
                    ref="%F{yellow}${ref#refs/heads/}+${ahead}%f"
                else
                    ref="%F{red}${ref#refs/heads/}+${ahead}-${behind}%f"
                fi
            fi
        fi
        
        # commit
        #   red    - unstaged changes present
        #   yellow - staged changes present
        #   green  - default
        if ! git diff-files --quiet --ignore-submodules --; then
            sha="%F{red}${sha}%f"
        elif ! git diff-index --cached --quiet HEAD --ignore-submodules --; then
            sha="%F{yellow}${sha}%f"
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
