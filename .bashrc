#!/bin/bash

stty -ixon # Disable ctrl-s and ctrl-q.
shopt -qs autocd #Allows you to cd into directory merely by typing the directory name.
HISTSIZE=HISTFILESIZE= # Infinite history.

export PS1="\[$(tput bold)\]\[$(tput setaf 1)\][\[$(tput setaf 5)\]\W\[$(tput setaf 1)\]]\[$(tput setaf 7)\]> \[$(tput sgr0)\]"

export GPG_TTY=$(tty)

# Some aliases
alias SS="sudo systemctl"
alias sv="sudo nvim"
alias ka="killall"
alias g="git"
alias mkd="mkdir -pv"
alias ref="shortcuts && source ~/.bashrc" # Refresh shortcuts manually and reload bashrc
alias yt="straw-viewer -C"
alias ytc="straw-viewer -C -sc"
alias ytdl="youtube-dl"
alias vim="$EDITOR"
alias torrent="tremc"
alias ka="killall"

# Adding color
alias ls='ls -hN --color=auto --group-directories-first'
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias ccat="highlight --out-format=ansi" # Color cat - print file with syntax highlighting.

source ${XDG_CONFIG_HOME}/shortcutrc
