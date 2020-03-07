### shell settings

# globbing
unsetopt NULL_GLOB
setopt NOMATCH

# jobs
setopt AUTO_CONTINUE
unsetopt NOTIFY

# misc
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt RM_STAR_WAIT
unsetopt BEEP

## umask
if [ $UID -eq 0 ]; then
    umask -S u=rwx,g=rx,o=rx
else
    umask -S u=rwx,g=,o=
fi

## history

# cleaner history
setopt HIST_IGNORE_DUPS
setopt HIST_NO_FUNCTIONS
setopt HIST_NO_STORE
setopt HIST_REDUCE_BLANKS

# prevent user error
setopt HIST_VERIFY
setopt HIST_IGNORE_SPACE

# workaround for nfs issues
setopt HIST_FCNTL_LOCK

# multi-vt workflow
setopt INC_APPEND_HISTORY
unsetopt SHARE_HISTORY

HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=25000

## modules
autoload -U colors && colors
