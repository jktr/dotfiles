#!/bin/sh

###
#
#  dotfiles.sh by Mustangflyer, 2015
#  This script is in the public domain. Enjoy.
#
# Instructions:
#  To create a new class of dotfiles:
#   1. Append the class name to the class array variable.
#   2. Create a destination variable for the class.
#   3. Create an array variable with file names for the class.
#  Example dotfiles.conf
#   class+=('bash')
#   bash_dest=~
#   bash_files=('.bashrc' '.bash_profile')
# Note:
#  1. Please don't run this as root. It's not even remotely secured.
#  2. Run this from outside the dotfiles directory.
#
###


### SCRIPT SETUP

dirname=$(dirname $0)
class=()


### LOAD USER CONF

conffile="${dirname}/dotfiles.conf"
if [ -e "$conffile" ]; then
  echo 'Found dotfiles.conf: loading...'
  source "$conffile"
fi

confdir="${dirname}/dotfiles.conf.d"
if [ -d "$confdir" ]; then
  for conf in $confdir/*.conf; do # if no .conf files, matches *.conf, urgh
    echo "Found .conf file $conf: loading..."
    source "$conf"
  done
fi


### MORE SCRIPT SETUP

alias errcho='>&2 echo'
vecho () {
  if [ "${verbose}" == 'VERBOSE' ]; then
    echo "$@"
  fi
}


### ACTIONS

symlinks_deploy () {
  for class in "${class[@]}"; do
    dest="${class}_dest"
    files="${class}_files[@]" # urgh
    for file in "${!files}"; do
      ln_dst="${!dest}/$file"
      ln_src="$dirname/$file"
      if [ ! -e "$ln_dst" ]; then # if file doesn't exist yet
        vecho "creating symlink from $ln_dst to $ln_src"
        ln --symbolic "$ln_src" "$ln_dst"
      else
        if [ "$force" == 'FORCE' ]; then
          errcho "creating symlink from $ln_dst to $ln_src: file already exists (manually created?), but you forced overwrite"
          ln --symbolic --force "$ln_src" "$ln_dst"
        else
          errcho "failed: creating symlink from $ln_dst to $ln_src: file already exists"
        fi
      fi
    done
  done
}

symlinks_undeploy () {
  for class in "${class[@]}"; do
    dest="${class}_dest"
    files="${class}_files[@]" # urgh
    for file in "${!files}"; do
      ln_dst="${!dest}/$file"
      ln_src="$dirname/$file"
      if [ -e "$ln_dst" ]; then # if a file exists at dest
        if [ "$ln_src" -ef "$ln_dst" ]; then # if file links to expected local dotfile
          vecho "removing link at $ln_dst"
          rm "$ln_dst"
        else
          if [ "$force" == 'FORCE' ]; then 
            errcho "removing file at $ln_dst: not linking to expected file (manually overwritten?), but you forced removal"
            rm "$ln_dst"
          else
            errcho "failed: removing link at $ln_dst: not linking to expected file (manually overwritten?)"
          fi
        fi
      else
        errcho "failed: removing link at $ln_dst: no such file/link exists"
      fi          
    done
  done
}


### COMMAND LINE PARSING

# defaults
action='DEPLOY'
force='NOFORCE'
verbose='NOVERBOSE'

while [[ $# > 0 ]]; do
  arg="$1"
  case $arg in
    'deploy')
      action='DEPLOY'
      ;;
    'undeploy')
      action='UNDEPLOY'
      ;;
    'redeploy')
      action="REDEPLOY"
      ;;
    'force')
      force='FORCE'
      ;;
    'verbose')
      verbose='VERBOSE'
      ;;
    *)
      ;;
  esac
  shift
done


### INVOKING

case $action in
  'DEPLOY')
    symlinks_deploy
    ;;
  'UNDEPLOY')
    symlinks_undeploy
    ;;
  'UNDEPLOY')
    symlinks_undeploy
    symlinks_deploy
    ;;
esac
