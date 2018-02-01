### history

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
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY

HISTFILE=~/.zsh_history
HISTSIZE=2000
SAVEHIST=25000
