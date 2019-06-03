#!/usr/bin/fish

function fish_prompt
    set_color red --bold
    printf "["
    set_color yellow
    printf "%s" "$USER"
    set_color green
    printf "@"
    set_color blue
    printf "%s" "$hostname"
    set_color magenta
    if test (pwd) = $HOME
        printf " %s" $HOME
    else
        printf " %s" (pwd | rev | cut -f1 -d '/' | rev)
    end
    set_color red
    printf "] "
    set_color normal
end

set fish_greeting "hello, world!"
