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
#alias hlog="cat /tmp/hypr/$(ls -t /tmp/hypr/ | head -n 1)/hyprland.log > hyprland.log"
alias gpu_mem="watch -n 0.5 nvidia-smi --query-gpu=memory.used --format=csv"
# alias gpu_info="watch -n 0.5 'nvidia-smi'"
# alias gpu_info="nvtop"
alias conf="cd ~/.config"
alias dots="cd ~/dotfiles"
alias dot="cd ~/dotfiles"
alias meld="GTK_THEME=Arc:dark meld"
alias plan="nvim ~/TimeManagement/Testing.md"
alias vpn="sudo openconnect vpn.jyu.fi/student"
alias fix="systemctl --user restart pipewire; systemctl --user daemon-reload"
alias tablet="systemctl --user daemon-reload; systemctl --user enable opentabletdriver --now"

alias tabletinstall="yay -S opentabletdriver-git; systemctl --user daemon-reload; systemctl --user enable opentabletdriver --now"
alias xfix="run xinput --set-prop 12 "libinput Accel Speed" -0.5; run xset r rate 200 170"

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

# Game mode for steam
# LD_PRELOAD="$LD_PRELOAD:/usr/\$LIB/libgamemode.so.0" gamemoderun %command% 

export PAGER=less

export HSA_OVERRIDE_GFX_VERSION=11.0.0
export VULKAN_SDK=~/vulkan/1.3.250.1/
export EDITOR=nvim 
export PATH=$PATH:$HOME/.local/bin:/opt/rocm/bin/:$VULKAN_SDK/x86_64/bin/
export QT_QPA_PLATFORMTHEME=qt5ct

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/home/patu/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/home/patu/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/home/patu/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/home/patu/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<

