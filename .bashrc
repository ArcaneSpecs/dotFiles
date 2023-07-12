#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

alias ll='ls -la --color=auto'

alias pkgsize="sudo pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}'| sort -hr"

alias hlog="cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -n 1)/hyprland.log > hyprland.log"

