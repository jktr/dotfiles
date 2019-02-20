### fn-laptop

# sets backlight brightness
brightness () {
    local -r max=950
    local -r min=1
    local -r usage="Usage: brightness [$min,$max]"

    case "$1" in
        ''|'-h'|'--help') # no args or help request
            echo "$usage"
            ;;
        *[!0-9]*) # > 0 non-numeric
            echo 'NaN...'
            echo "$useage"
            ;;
        *) # only numeric
            if [ $1 -gt $max -o $1 -lt $min ]; then
                echo 'Outside range'
                echo "$usage"
            else
                sudo sh -c \
                     "echo $1 > /sys/class/backlight/intel_backlight/brightness"
            fi
            ;;
    esac
}
