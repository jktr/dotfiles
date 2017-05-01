### functions.sh

# prints process environment by pid or process name
envof () {
    case $1 in
        ''|'-h'|'--help') # no args or help request
            echo "Usage: envof (pid|progname)"
            ;;
        *[!0-9]*) # string has at least one non-numeric char
            for pid in $(pidof $1); do
                echo "----------- $pid -----------"
                xargs --null --max-args=1 < "/proc/${pid}/environ"
            done
            ;;
        *) # args has only numeric chars
            xargs --null --max-args=1 < "/proc/$1/environ"
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


# prints largest directories by size on disk
heavy () {
    if [ -d "$1" ]; then
        du --max-depth=1 -h "$1" | sort -hr
    else
        du --max-depth=1 -h "${PWD}" | sort -hr
    fi
}

# generates new ssh key
ssh-keygen () {
    ssh-keygen -t ed25519
               -f "~/.ssh/keys/id_ed25519_$1_$(date +%Y-%m-%d)"
               -C "$HOST::$1::$2"
}
