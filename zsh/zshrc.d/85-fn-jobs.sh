### fn-jobs

# prints process environment by pid or process name
# htop's 'E' can do this, too
envof () {
    case $1 in
        ''|'-h'|'--help') # no args or help request
            echo "Usage: envof (pid|progname)"
            ;;
        *[!0-9]*) # string has at least one non-numeric char
            for pid in $(pidof $1); do
                echo "----------- $pid -----------"
                xargs --null --max-args=1 < "/proc/${pid}/environ" |sort
            done
            ;;
        *) # args has only numeric chars
            xargs --null --max-args=1 < "/proc/$1/environ" |sort
            ;;
    esac
}


# prints process status by pid or process name
statusof () {
    case $1 in
        ''|'-h'|'--help') # no args or help request
            echo "Usage: statusof (pid|progname)"
            ;;
        *[!0-9]*) # string has at least one non-numeric char
            for pid in $(pidof $1); do
                echo "----------- $pid -----------"
                cat "/proc/${pid}/status"
            done
            ;;
        *) # args has only numeric chars
            cat "/proc/$1/status"
            ;;
    esac
}
