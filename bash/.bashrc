#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# fastfetch

# PS1='\w\$ '
# PS1='\[\e[34m\]\w\[\e[0m\]>> '
PS1='\[\e[38;2;191;85;236m\]\w\[\e[0m\]>> '



