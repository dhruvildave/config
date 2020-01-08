#!/bin/env bash
# Cross-platform linux update script
# Mon Dec 30 23:14:13 IST 2019
# Author: https://github.com/dhruvildave

readonly dist="$(grep -w "ID" /etc/os-release | cut -d= -f2)"  # Find the name of distro

yellow() { echo -e "\\nUpdating \\033[01;33m$1\\033[00m"; }  # Prints the argument in yellow color

# Base package manager
if [ "$dist" == "fedora" ] || [ "$dist" == "centos" ]; then
    if [ -x "$(command -v dnf)" ]; then
        yellow "dnf"
        sudo dnf upgrade -y
    fi
elif [ "$dist" == "debian" ] ||
     [ "$dist" == "ubuntu" ] ||
     [ "$dist" == "kali" ]; then
    if [ -x "$(command -v apt)" ]; then
        yellow "apt"
        sudo apt update
        sudo apt full-upgrade -y
        sudo apt autoremove -y
    fi
fi

# Conda
if [ -x "$(command -v conda)" ]; then
    yellow "conda->base"
    conda update --all -y -n base
    if [ -d "$HOME/miniconda3/" ]; then
        for i in "$HOME/miniconda3/envs"/*; do
            [[ -e "$i" ]] || break  # No user defined envs
            name="$(echo "$i" | rev | cut -d/ -f1 | rev)"
            if [ "$name" == "torch" ]; then
                continue  # Do not update torch
            fi

            yellow "conda->$name"
            conda update --all -y -n "$name"
        done
    fi
    unset name
fi

# Flatpak
yellow "flatpak"
if [ -x "$(command -v flatpak)" ]; then
    flatpak update -y
fi

# NodeJS
if [ -x "$(command -v node | grep -w nvm)" ]; then
    yellow "NodeJS"
    ver="$(node --version)"
    . "$NVM_DIR/nvm.sh"
    nvm install node --reinstall-packages-from=node
    if [ "$(node --version)" != "$ver" ]; then
        nvm uninstall "$ver"
    fi
    nvm use node
    unset ver
fi

unset -f yellow
