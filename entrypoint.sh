#!/bin/sh

if ! (aur repo > /dev/null 2>&1); then
    printf "Aur repo not initialized, initializing /repo...\n"
    repo-add /repo/custom.db.tar.gz
fi

sudo pacman --noconfirm -Syu
exec "$@"
