### shopt

# globbing
unsetopt NULL_GLOB
setopt NO_MATCH
setopt GLOB_STAR_SHORT

# jobs
setopt AUTO_CONTINUE
setopt HUP
unsetopt NOTIFY

# misc
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
setopt SHWORDSPLIT
setopt RM_STAR_WAIT
setopt RC_QUOTES
unsetopt BEEP

# modules
autoload -U colors && colors

