### functions.zshrc

# prints process environment by pid or process name
envof () {
  case $1 in
    ''|'-h'|'--help') # no args or help request
      echo "Usage: envof (pid|progname)"
      ;;
    *[!0-9]*) # string has at least one non-numeric char
      for pid in $(pidof $1); do
        echo "----------- $pid -----------"
        xargs --null --max-args=1 < "/proc/$pid/environ"
      done
      ;;
    *) # args has only numeric chars
      xargs --null --max-args=1 < "/proc/$1/environ"
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

