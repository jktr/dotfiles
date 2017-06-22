### fn-laptop

# retrieves current battery level
battery_level () {    
    local -r bat="/sys/class/power_supply/BAT*"

    full=$(< "${bat}/charge_full")
    now=$(< "${bat}/charge_now")

    percent=$(echo "100*($now/$full)" | bc -l )
    echo "$bat: ${full}/${now} -> ${percent}"
}

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
            exit 1
            ;;
        *) # only numeric
            if [ $1 -gt $max -o $1 -lt $min ]; then
                echo 'Outside range'
                echo "$usage"
                exit 1
            else
                sudo sh -c \
                     "echo $1 > /sys/class/backlight/intel_backlight/brightness"
            fi
            ;;
    esac
}

# man sets /dev/sda to contiuouly spin to reduce wear
alias nosleep-sda='sudo hdparm -B 128 -S 60 /dev/sda'
