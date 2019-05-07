# The following lines were added by compinstall
zstyle :compinstall filename '/home/dhruvil/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob nomatch notify
setopt +o nomatch
bindkey -e
# End of lines configured by zsh-newuser-install

if [ -f ~/.zsh_aliases ]; then
	. ~/.zsh_aliases
fi
