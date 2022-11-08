#!/bin/sh

if ! (aur repo > /dev/null 2>&1); then
    printf "Aur repo not initialized, initializing /repo...\n"
    repo-add /repo/custom.db.tar.xz
fi

sudo pacman --noconfirm -Syu
repoctl conf new "$(readlink -f /repo/custom.db)"
exec "$@"
