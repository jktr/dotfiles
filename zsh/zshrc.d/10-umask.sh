### umask.zshrc

if [ $UID -eq 0 ]; then
    umask -S u=rwx,g=rx,o=rx
else
    umask -S u=rwx,g=,o=
fi
