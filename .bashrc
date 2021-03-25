#!/usr/bin/env bash

# Sample .bashrc for SuSE Linux
# Copyright (c) SuSE GmbH Nuernberg

# There are 3 different types of shells in bash: the login shell, normal shell
# and interactive shell. Login shells read ~/.profile and interactive shells
# read ~/.bashrc; in our setup, /etc/profile sources ~/.bashrc - thus all
# settings made here will also take effect in a login shell.
#
# NOTE: It is recommended to make language settings in ~/.profile rather than
# here, since multilingual X sessions would not work properly if LANG is over-
# ridden in every subshell.

# Some applications read the EDITOR variable to determine your favourite text
# editor. So uncomment the line below and enter the editor of your choice :-)
#export EDITOR=/usr/bin/vim
#export EDITOR=/usr/bin/mcedit

# For some news readers it makes sense to specify the NEWSSERVER variable here
#export NEWSSERVER=your.news.server

# If you want to use a Palm device with Linux, uncomment the two lines below.
# For some (older) Palm Pilots, you might need to set a lower baud rate
# e.g. 57600 or 38400; lowest is 9600 (very slow!)
#
#export PILOTPORT=/dev/pilot
#export PILOTRATE=115200

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

test -s ~/.alias && . ~/.alias || true

# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ $HOME/.local/bin:$HOME/bin:/usr/sbin:/usr/local/cuda/bin ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH:/usr/sbin:/usr/local/cuda/bin"
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
    export LD_LIBRARY_PATH="/usr/local/cuda/lib64/:$LD_LIBRARY_PATH"
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# User specific aliases and functions
alias grep="grep --color -E"
alias ...="cd ../../"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=erasedups:ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

bind "set editing-mode emacs"
shopt -s cdspell
shopt -s autocd
bind "set show-all-if-ambiguous on"
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
bind "TAB: menu-complete"

# Prompt
# PS1="\033[01;32m┌──(\033[00m\]\033[01;33m\]\u@\h\033[00m\]\033[01;32m)-"
# PS1+="[\033[00m\]\033[01;34m\w\033[00m\]\033[01;32m] \033[01;32m(\033[00m\]\033[01;37m\$?\033[00m\]\033[01;32m)\033[00m\]\n"
# PS1+="\033[01;32m└─\033[00m\]\033[01;34m\]$\033[00m\] "
# export PS1
# export PS1="\033[01;35m[\033[00m\[\033[01;35m\]\u@\h\[\033[00m\] \[\033[01;36m\]\W\[\033[00m\]\033[01;35m]\033[00m$ "
export PS1="\[\e[32m\]\u\[\e[m\] \[\e[33m\]\W\[\e[m\] > "

# Deno
if [[ -f "/home/dhruvil/.deno/bin/deno" ]]; then
    export DENO_INSTALL="/home/dhruvil/.deno"
    export PATH="$DENO_INSTALL/bin:$PATH"
fi
eval "$(deno completions bash)"

# GitHub CLI
eval "$(gh completion -s bash)"

# k8s
eval "$(minikube completion bash)"

eval "$(poetry completions bash)"

# Containers
# [[ -f "$HOME/containers/.docker_aliases.sh" ]] && . $HOME/containers/.docker_aliases.sh

# tmux
if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux
fi

# Archive Extraction
# usage: ex <file>
ex() {
    if [ -f "$1" ]; then
        case "$1" in
        *.tar.bz2) tar xjf "$1" ;;
        *.tar.gz) tar xzf "$1" ;;
        *.bz2) bunzip2 "$1" ;;
        *.rar) unrar x "$1" ;;
        *.gz) gunzip "$1" ;;
        *.tar) tar xf "$1" ;;
        *.tbz2) tar xzf "$1" ;;
        *.zip) unzip "$1" ;;
        *.Z) uncompress "$1" ;;
        *.7z) 7z x "$1" ;;
        *.tar.xz) tar xf "$1" ;;
        *.tar.zst) unzstd "$1" ;;
        esac
    else
        echo "$1 could not extracted by ex"
    fi
}

# Remove duplicate PATH entries
PATH="$(python3 -c 'import os; print(":".join(set(os.environ["PATH"].split(":"))))')"
export PATH

[ -f "$HOME/.kube/config" ] && KUBECONFIG="$HOME/.kube/config" && export KUBECONFIG

man() {
    LESS_TERMCAP_mb=$'\e[1;37m' \
        LESS_TERMCAP_md=$'\e[1;34m' \
        LESS_TERMCAP_so=$'\e[01;36m' \
        LESS_TERMCAP_us=$'\e[01;35m' \
        LESS_TERMCAP_me=$'\e[0m' \
        LESS_TERMCAP_se=$'\e[0m' \
        LESS_TERMCAP_ue=$'\e[0m' \
        GROFF_NO_SGR=1 \
        command man "$@"
}

source "$HOME/.cargo/env"
eval "$(rustup completions bash)"
eval "$(rustup completions bash cargo)"

eval "$(kubectl completion bash)"
