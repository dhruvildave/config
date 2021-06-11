#!/usr/bin/env bash

alias R="R --no-save"

alias py3="python3"

alias r="ranger"

alias data="cd /mnt/DATA"

alias codes="data; cd Documents/codes"

alias clg="data; cd Documents/clg"

alias ref="codes; cd reference-books"

alias py="ipython3 || python3"

alias jl="jupyter-lab"

alias ca="conda activate"

alias clip="xclip -sel c"

alias cat="bat"

alias aws="docker run -it --rm amazon/aws-cli"

alias podman="sudo podman"

alias pg='sudo podman run -it --rm -p 5432:5432 -e "POSTGRES_PASSWORD=tough-pwd-13" postgres'

alias mssql='sudo podman run -it --rm -p 1433:1433 -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=tough-pwd-13" mcr.microsoft.com/mssql/server'
