#!/bin/sh

dirname=$(dirname $0)
declare -A dest

# list destination classes here:
class=(home)

# list destinations and files for each class here:
home_dest=~
home_files=(.zshrc .xinitrc .xserverrc)

# do symlinking
for class in "${class[@]}"; do
  dest="${class}_dest"
  files="${class}_files[@]" # urgh
  for file in "${!files}"; do
    echo "symlinking ${!dest}/$file to $dirname/$file"
    ln -s "${dirname}/${file}" "${!dest}/${file}"
  done
done
