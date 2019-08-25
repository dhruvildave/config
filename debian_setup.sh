#!/bin/bash
# Sun Aug 25 11:26:18 IST 2019
# Works in Debian GNU/Linux 10 (buster)

# How to use:
# First download the script and then enter the following commands
# chmod 0755 debian_setup.sh
# ./debian_setup.sh

# Setting bash vi mode
echo "set -o vi" >> ~/.bashrc

# Setting recursive globbing in bash
echo "shopt -s globstar" >> ~/.bashrc

# Setting up certain useful aliases
echo "alias R=\"R --no-save\"" >> ~/.bash_aliases
echo "alias py3=\"python3\"" >> ~/.bash_aliases

sudo apt update
sudo apt upgrade -y
sudo apt remove libreoffice* -y
sudo apt install emacs \
                 git \
                 clang \
                 g++ \
                 valgrind \
                 cmake \
                 wget \
                 curl \
                 tree \
                 clang-format \
                 clang-tidy \
                 gdb \
                 lldb \
                 llvm \
                 openjdk-11-jdk \
                 r-base \
                 python3-dev \
                 texlive \
                 vim \
                 ess \
                 numix-gtk-theme \
                 numix-icon-theme-circle \
                 zsh \
                 fish \
                 scilab \
                 golang \
                 ffmpeg \
                 postgresql \
                 lighttpd \
                 flatpak \
                 gnome-software-plugin-flatpak

if [ -x "$(command -v curl)" ]; then
    # Miniconda setup
    curl -O https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
    chmod 0755 Miniconda3-latest-Linux-x86_64.sh
    ./Miniconda3-latest-Linux-x86_64.sh

    # VSCode setup
    curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -o root -g root -m 644 packages.microsoft.gpg /usr/share/keyrings/
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
    sudo apt install apt-transport-https
    sudo apt update
    sudo apt install code
else
    echo "cURL not installed"
    echo "Miniconda install failed"
    echo "VSCode install failed"
fi

if [ -x "$(command -v flatpak)" ]; then
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    flatpak install spotify \
                    blender \
                    gimp \
                    inkscape \
                    kdenlive \
                    libreoffice \
                    octave
else
    echo "flatpak not installed"
    echo "Spotify install failed"
    echo "GIMP install failed"
    echo "Inkscape install failed"
    echo "Kdenlive install failed"
    echo "Libreoffice install failed"
    echo "GNU Octave install failed"
fi

if [ $? -eq 0 ]; then
    echo "Please close the shell and reboot the system"
else
    echo "There are certain installation errors detected in your system"
fi
