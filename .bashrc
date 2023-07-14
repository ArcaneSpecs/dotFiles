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
alias gpu_mem="watch -n 0.5 nvidia-smi --query-gpu=memory.used --format=csv"
alias gpu_info="watch -n 0.5 'nvidia-smi'"

export PATH=$PATH:$HOME/.local/bin
export QT_QPA_PLATFORMTHEME=qt5ct

