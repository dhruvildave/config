#!/usr/bin/env bash

# Cross-platform linux update script
# Mon Dec 30 23:14:13 IST 2019
# Author: https://github.com/dhruvildave

dist="$(grep -w "ID" /etc/os-release | cut -d= -f2)" # Find the name of distro
readonly dist

# Prints the argument in yellow color
yellow() {
    echo -e "\\nUpdating \\033[01;33m$1\\033[00m"
}

[[ -n "$(pgrep package)" ]] && sudo kill "$(pgrep package)"

# Base package manager
case "$dist" in
"fedora" | "\"centos\"")
    yellow "dnf" &&
        sudo dnf upgrade -y
    ;;

"debian" | "pop" | "kali")
    yellow "apt" &&
        sudo apt update &&
        sudo apt full-upgrade -y &&
        sudo apt autoremove -y
    ;;

"\"opensuse-tumbleweed\"" | "\"opensuse-leap\"")
    yellow "zypper" &&
        sudo zypper ref &&
        sudo zypper dup -y
    ;;
esac

# Conda
[[ -x "$(command -v conda)" ]] &&
    yellow "conda->base" &&
    conda update --all -y -n base &&
    [[ -d "$HOME/miniconda3/" ]] &&
    for i in "$HOME/miniconda3/envs"/*; do
        [[ -e "$i" ]] || break # No user defined envs
        name="$(echo "$i" | rev | cut -d/ -f1 | rev)"

        yellow "conda->$name"
        conda update --all -y -n "$name" \
            -c conda-forge -c plotly -c pytorch
    done
unset name

# Flatpak
yellow "flatpak"
[[ -x "$(command -v flatpak)" ]] &&
    flatpak update -y

# NodeJS
if [[ -x "$(command -v node | grep -w nvm)" ]]; then
    yellow "NodeJS" &&
        ver="$(node --version)" &&
        . "$NVM_DIR/nvm.sh" &&
        nvm install node &&
        if [[ "$(node --version)" != "$ver" ]]; then
            nvm uninstall "$ver" &&
                nvm use node &&
                npm i -g yarn pnpm &&
                pnpm add -g typescript prettier nodemon serve parcel &&
                unset ver
        fi
fi

# Deno
if [[ -x "$(command -v deno)" ]]; then
    yellow "Deno"
    deno upgrade
fi

# Rust
if [[ -x "$(command -v rustup)" ]]; then
    yellow "Rust"
    rustup self update
    rustup update
fi

# Docker
[[ -x "$(command -v docker)" ]] &&
    yellow "Docker" &&
    for i in $(docker images | awk 'NR > 1 { print $1":"$2 }'); do
        docker pull "$i"
    done &&
    docker system prune -f

# Podman
# yellow "Podman" &&
#     [ -f "$HOME/Documents/update-podman.sh" ] &&
#     sudo "$HOME/Documents/update-podman.sh"

unset -f yellow
