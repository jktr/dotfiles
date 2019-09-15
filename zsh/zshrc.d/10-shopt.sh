### shopt

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

# modules
autoload -U colors && colors
