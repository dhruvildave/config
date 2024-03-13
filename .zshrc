#!/usr/bin/env zsh

# pnpm
export PNPM_HOME="/Users/tushar/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

setopt autocd              # change directory just by typing its name
setopt correct             # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode
setopt ksharrays           # arrays start at 0
setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt
setopt menu_complete       # select menu options on pressing tab

# enable completion features
autoload -Uz compinit
compinit -d ~/.cache/zcompdump
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case insensitive tab completion
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=** r:|=**' 'l:|=* r:|=*'

# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
# setopt share_history          # share command history data

# force zsh to show the complete history
alias history="history 0"

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PROMPT=$'%B%F{blue}%n%F{reset} %1~ %F{blue}>%b%F{reset} '

    # enable syntax-highlighting
    if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && [ "$color_prompt" = yes ]; then
	# ksharrays breaks the plugin. This is fixed now but let's disable it in the
	# meantime.
	# https://github.com/zsh-users/zsh-syntax-highlighting/pull/689
	unsetopt ksharrays
	. /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
	ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
	ZSH_HIGHLIGHT_STYLES[default]=none
	ZSH_HIGHLIGHT_STYLES[unknown-token]=fg=red,bold
	ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
	ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
	ZSH_HIGHLIGHT_STYLES[global-alias]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
	ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
	ZSH_HIGHLIGHT_STYLES[path]=underline
	ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
	ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
	ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[command-substitution]=none
	ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[process-substitution]=none
	ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
	ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
	ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
	ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
	ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta
	ZSH_HIGHLIGHT_STYLES[assign]=none
	ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[comment]=fg=black,bold
	ZSH_HIGHLIGHT_STYLES[named-fd]=none
	ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
	ZSH_HIGHLIGHT_STYLES[arg0]=fg=green
	ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
	ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
	ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
    fi
else
    PROMPT='%n@%m:%~%# '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    TERM_TITLE='\e]0;%n@%m: %~\a'
    ;;
*)
    ;;
esac

new_line_before_prompt=yes
precmd() {
    # Print the previously configured title
    print -Pn "$TERM_TITLE"

    # Print a new line before the prompt, but only if it is not the first line
    if [ "$new_line_before_prompt" = yes ]; then
	if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
	    _NEW_LINE_BEFORE_PROMPT=1
	else
	    print ""
	fi
    fi
}

# enable color support of ls, less and man, and also add handy aliases
alias ls="ls --color"
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias diff='diff --color=auto'
    alias ip='ip --color=auto'

    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
fi

# some more ls aliases
alias ...="../../"
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias R="R --no-save"
alias py3="python3"
alias r="ranger"
alias mnt="cd /mnt/nvme0n1p7"
alias data="cd ~/Documents"
alias codes="data; cd codes"
alias clg="data; cd clg"
alias ref="codes; cd reference-books"
alias mbh="ref; cd mahābhārata/uoft"
alias py="ipython3 || python3"
alias jl="jupyter-lab"
# alias code="code-insiders"
alias ca="conda activate"
alias clip="xclip -sel c"
alias nvim="lvim"
# alias cat="bat"
# alias aws="docker run -it --rm -v "$PWD":/aws amazon/aws-cli"
# alias podman="sudo podman"
alias trino='docker run -it --rm -p 8080:8080 -v "$PWD":/usr/src:z -w /usr/src --name trino trinodb/trino'
alias mysql='docker run -it --rm --name mysql -v "$PWD":/usr/src:z -w /usr/src -p 3306:3306 -p 33060:33060 -e "MYSQL_ROOT_PASSWORD=tough-pwd-pg" mysql'
alias pg='docker run -it --rm --name pg -v "$PWD":/usr/src:z -w /usr/src -p 5432:5432 -e "POSTGRES_PASSWORD=tough-pwd-pg" postgres'
# https://kafka.apache.org/quickstart
# https://developer.confluent.io/get-started/java/
alias kafka='docker run -it --rm -p 9092:9092 --name kafka apache/kafka'
alias pg-v='docker run -it --rm --name pg -v "$PWD":/usr/src:z -v "$PWD"/pg_data:/var/lib/postgresql/data:z -w /usr/src -p 5432:5432 -e "POSTGRES_PASSWORD=tough-pwd-pg" postgres'
alias pg-gis='docker run -it --rm --name pg -v "$PWD":/usr/src:z -w /usr/src -p 5432:5432 -e "POSTGRES_PASSWORD=tough-pwd-pg" postgis/postgis'
alias pg-gis-v='docker run -it --rm --name pg -v "$PWD":/usr/src:z -v "$PWD"/pg_data:/var/lib/postgresql/data:z -w /usr/src -p 5432:5432 -e "POSTGRES_PASSWORD=tough-pwd-pg" postgis/postgis'
alias pg-ts-gis='docker run -it --rm --name pg-ts-gis -v "$PWD":/usr/src:z -w /usr/src -p 5432:5432 -e "POSTGRES_PASSWORD=tough-pwd-pg" timescale/timescaledb-ha:pg14-latest'
alias mssql='docker run -it --rm -p 1433:1433 -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=tough-pwd-13" mcr.microsoft.com/mssql/server'
# alias n4j='docker run -it --rm --name n4j -p 7474:7474 -p 7687:7687 -v "$PWD":/usr/src:z -w /usr/src -e "NEO4J_AUTH=none" -e "NEO4JLABS_PLUGINS=[\"apoc\", \"graph-data-science\", \"n10s\"]" -e "NEO4J_apoc_export_file_enabled=true" -e "NEO4J_apoc_import_file_enabled=true" neo4j'
alias jl-ds-v='docker run -it --rm --gpus all -u root -e GRANT_SUDO=yes --name jl-ds -v "$PWD":/home/jovyan -p 8888:8888 jupyter/datascience-notebook'
alias jl-spark-v='docker run -it --rm --gpus all -u root -e GRANT_SUDO=yes --name jl-spark -v "$PWD":/home/jovyan -p 8888:8888 jupyter/all-spark-notebook'
alias jl-ds='docker run -it --rm --gpus all -u root -e GRANT_SUDO=yes -e GEN_CERT=yes --name jl-ds -v ~/ssl:/etc/ssl -p 8888:8888 jupyter/datascience-notebook'
alias jl-spark='docker run -it --rm --gpus all -u root -e GRANT_SUDO=yes --name jl-spark -p 8888:8888 jupyter/all-spark-notebook'
alias grafana='docker run -it --rm -p 3000:3000 grafana/grafana-enterprise'
# alias sqlfluff='docker run -it --rm -v "$PWD":/sql sqlfluff/sqlfluff'

# enable auto-suggestions based on the history
if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
    . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

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

# User specific environment
if ! [[ "$PATH" =~ /usr/local/go/bin ]]; then
    PATH="/usr/local/go/bin:$PATH"
fi
export PATH

if ! [[ "$PATH" =~ $HOME/go/bin ]]; then
    PATH="$HOME/go/bin:$PATH"
fi
export PATH

if ! [[ "$PATH" =~ $HOME/.local/bin ]]; then
    PATH="$HOME/.local/bin:$PATH"
fi
export PATH

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%B%F{green}(%b)%r%f'
zstyle ':vcs_info:*' enable git

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

PATH="$(python3 -c 'import os; print(":".join(set(os.environ["PATH"].split(":"))))')"
export PATH

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
compinit

[ -x "$(command -v quarkus)" ] && source <(quarkus completion)
[ -x "$(command -v deno)" ] && source <(deno completions zsh)
[ -x "$(command -v buf)" ] && source <(buf completion zsh)
