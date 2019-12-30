#!/bin/env bash
# Cross-platform linux update script

readonly dist="$(grep -w "ID" /etc/os-release | cut -d= -f2)"  # Find the name of distro

# Base package manager
if [ "$dist" == "fedora" ] || [ "$dist" == "centos" ]; then
    if [ -x "$(command -v dnf)" ]; then
        sudo dnf upgrade -y
    fi
elif [ "$dist" == "debian" ] || [ "$dist" == "ubuntu" ]; then
    if [ -x "$(command -v apt)" ]; then
        sudo apt update
        sudo apt full-upgrade -y
        sudo apt autoremove -y
    fi
fi

# Conda
if [ -x "$(command -v conda)" ]; then
    echo -e "\\nUpdating \\033[01;33mbase\\033[00m"
    conda update --all -y -n base
    if [ -d "$HOME/miniconda3/" ]; then
        for i in "$HOME/miniconda3/envs"/*; do
            [[ -e "$i" ]] || break  # No user defined envs
            name="$(echo "$i" | rev | cut -d/ -f1 | rev)"
            if [ "$name" == "torch" ]; then
                continue  # Do not update torch
            fi

            echo -e "\\nUpdating \\033[01;33m$name\\033[00m"
            conda update --all -y -n "$name"
        done
    fi
    unset name
fi

# Flatpak
if [ -x "$(command -v flatpak)" ]; then
    flatpak update -y
fi
