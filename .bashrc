#
# ~/.bashrc
#

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return
# PS1='[\u@\h \W]\$ '

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ll='ls -la --color=auto'
alias pkgsize="sudo pacman -Qi | awk '/^Name/{name=$3} /^Installed Size/{print $4$5, name}'| sort -hr"
alias hlog="cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -n 1)/hyprland.log > hyprland.log"
alias gpu_mem="watch -n 0.5 nvidia-smi --query-gpu=memory.used --format=csv"
alias gpu_info="watch -n 0.5 'nvidia-smi'"
alias conf="cd ~/.config"
alias dots="cd ~/dotfiles"
alias dot="cd ~/dotfiles"
alias meld="GTK_THEME=Arc:dark meld"
alias plan="nvim ~/TimeManagement/Testing.md"

export VULKAN_SDK=~/vulkan/1.3.250.1/
export EDITOR=nvim 
export PATH=$PATH:$HOME/.local/bin:/opt/rocm/bin/:$VULKAN_SDK/x86_64/bin/
export QT_QPA_PLATFORMTHEME=qt5ct

