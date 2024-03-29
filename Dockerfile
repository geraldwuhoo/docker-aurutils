FROM docker.io/library/archlinux:base-devel

LABEL ver="15.5"

RUN pacman --noconfirm -Syu && \
    pacman --noconfirm -S git jq pacutils expect vim vifm && \
    pacman --noconfirm -Scc

COPY entrypoint.sh /entrypoint.sh
RUN echo '%wheel ALL=(ALL:ALL) NOPASSWD: ALL' >> /etc/sudoers && \
    useradd --uid 1000 --shell /bin/bash --groups wheel --create-home aurutils && \
    install -d /repo -o aurutils && \
    chmod +x /entrypoint.sh

VOLUME ["/repo"]

USER aurutils
WORKDIR /home/aurutils

RUN git clone https://aur.archlinux.org/aurutils.git && \
    cd aurutils && \
    sudo pacman --noconfirm -Syu && \
    makepkg --noconfirm --syncdeps --rmdeps -si && \
    cd .. && \
    rm -rf aurutils && \
    sudo pacman --noconfirm -Scc

RUN git clone https://aur.archlinux.org/repoctl.git && \
    cd repoctl && \
    sudo pacman --noconfirm -Syu && \
    makepkg --noconfirm --syncdeps --rmdeps -si && \
    cd .. && \
    rm -rf repoctl && \
    sudo pacman --noconfirm -Scc

COPY pacman.conf /etc/pacman.conf

ENTRYPOINT ["/entrypoint.sh"]
