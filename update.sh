#!/usr/bin/env bash

# Cross-platform linux update script
# Mon Dec 30 23:14:13 IST 2019
# Author: https://github.com/dhruvildave

readonly dist="$(grep -w "ID" /etc/os-release | cut -d= -f2)" # Find the name of distro

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
        sudo zypper ref &&
        sudo zypper dup -y
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
        conda update --all -y -n "$name"
    done
unset name

# Flatpak
yellow "flatpak"
[[ -x "$(command -v flatpak)" ]] &&
    sudo flatpak update -y

# NodeJS
if [[ -x "$(command -v node | grep -w nvm)" ]]; then
    yellow "NodeJS" &&
        ver="$(node --version)" &&
        . "$NVM_DIR/nvm.sh" &&
        nvm install --lts &&
        if [[ "$(node --version)" != "$ver" ]]; then
            nvm uninstall "$ver" &&
                nvm use node &&
                unset ver
        fi
fi
unset -f yellow
