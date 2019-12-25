#!/bin/env bash
# Cross-platform linux update script

dist="$(grep "NAME" /etc/os-release | awk 'NR==1' | cut -d= -f2)"  # Find the name of distro

# Base package manager
if [ "$dist" == "Fedora" ] || [ "$dist" == "CentOS" ]; then
    if [ -x "$(command -v dnf)" ]; then
        sudo dnf upgrade -y
    fi
elif [ "$dist" == "Debian" ] || [ "$dist" == "Ubuntu" ]; then
    if [ -x "$(command -v apt)" ]; then
        sudo apt update
        sudo apt full-upgrade -y
        sudo apt autoremove -y
    fi
fi

# Conda
if [ -x "$(command -v conda)" ]; then
    conda update --all -y -n base
    if [ -d "$HOME/miniconda3/" ]; then
        for i in "$HOME/miniconda3/envs"/*; do
            [[ -e "$i" ]] || break  # No user defined envs
            name="$(echo "$i" | rev | cut -d/ -f1 | rev)"
            conda update --all -y -n "$name"
        done
    fi
fi

# Flatpak
if [ -x "$(command -v flatpak)" ]; then
    flatpak update -y
fi
