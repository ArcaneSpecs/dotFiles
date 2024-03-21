#
# ~/.bashrc
#

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return
# PS1='[\u@\h \W]\$ '

alias make='make -j32'
alias ls='eza --icons --color=auto'
alias grep='grep --color=auto'
alias ll='eza --icons --grid --all --color=auto'
# alias l.="/usr/bin/ls -GA | grep '^[ . . .]' | pr -t -6"
# alias l.="eza --all --icons -1 | grep '^( | | )'"
# alias l.="eza --all --icons -1"
# alias l.="eza --icons --all -1 --color=never | grep -E '^( | | | | | |󱆃 )\.' | column -t"
alias l.="eza --icons --all --color=never | grep -E '^\.' | column"

# sudo mount -t iso9660 -o ro,loop /path/to/file.iso /mount-point 
alias mountiso="sudo mount -t iso9660 -o ro,loop"
# mkisofs -V "ARCHIVE_2013_07_27" -J -r -o isoimage.iso ./for_iso
# nameofiso.iso ./folder_to_iso
alias mkiso="mkisofs -V 'ARCHIVE_2013_07_27'-J -r -o"
# -mod "/home/patu/Games/bfme2/drive_c/users/patu/Application Data/My Battle for Middle-earth(tm) II Files/HDEdition.big"
alias pkgsize="sudo pacman -Qi | awk '/^Name/{name=\$3} /^Installed Size/{print \$4\$5, name}'| sort -hr | less"
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
# alias fix="systemctl --user restart pipewire; systemctl --user daemon-reload"

alias tablet="systemctl --user daemon-reload; systemctl --user enable opentabletdriver --now"
alias tabletinstall="yay -S opentabletdriver-git; systemctl --user daemon-reload; systemctl --user enable opentabletdriver --now; echo 'blacklist wacom' | sudo tee -a /etc/modprobe.d/blacklist.conf; sudo rmmod wacom"

# alias xfix="xinput --set-prop 10 'libinput Accel Speed' 0.0 && xset r rate 200 200"
alias xfix="xinput --set-prop 'pointer:''Logitech USB Receiver' 'libinput Accel Profile Enabled' 0, 1 && xinput --set-prop 'pointer:''Logitech USB Receiver' 'libinput Accel Speed' 0.0 && xset r rate 200 200"
alias sshfix="eval \$(ssh-agent -s) && ssh-add ~/.ssh/id_rsa && ssh-add ~/.ssh/id_ed25519"
alias make_all="make -j32 config=release& make -j32 config=debug& make -j32 config=production"

alias history_timestamps='HISTTIMEFORMAT="%Y-%m-%d %T "'
alias history='history -i'
alias hs='history -i'

alias kdenlive='flatpak run org.kde.kdenlive'

alias ff='nvim "$(fzf)"'

alias memuse='function _memuse(){ cat /proc/$1/smaps | grep Rss | awk '\''{print $2}'\'' | awk '\''{s+=$1} END {printf "%.0f\n", s/1024}'\'' /dev/stdin; }; _memuse'

alias cmatrix="cmatrix -bas -C cyan"

# Try to attach to a tmux session, if not create one
alias ta="tmux attach || tmux new-session"

alias kubectl="minikube kubectl --"

# Alias to generate Wyvern Runtime makefiles
# INFO: (run in games build directory)
# Check the path to engine scripts dir depending what version you want to use
# This alias is useful for manually editing the premake file and not generating one using the engine
# (comes in handy when we are developing new links etc.)
alias gen_game='~/dev/simple_wyvern/Scripts/Linux-GenGameMakefile.sh $(realpath "$(pwd)/..")'

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

alias nuke="cd .. && rm -rf build && mkdir build && cd build && ../Scripts/Linux-GenProjects.sh && make -j32"

alias ses='tmux-sessionizer'

# export DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=1
# export AMD_VULKAN_ICD=RADV

export MANGOHUD=0

# Game mode for steam
#   LD_PRELOAD="$LD_PRELOAD:/usr/\$LIB/libgamemode.so.0" gamemoderun %command% 
#
# # Starfield fix on arch
# Need:  vulkan-radeon and lib32-vulkan-radeon
#   DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=1 VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json PROTON_LOG=1 %command%
#DISABLE_LAYER_AMD_SWITCHABLE_GRAPHICS_1=1 VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.i686.json:/usr/share/vulkan/icd.d/radeon_icd.x86_64.json PROTON_LOG=1 %command%

export PAGER=less

export XCURSOR_THEME=Adwaita
export XCURSOR_SIZE=24

export HSA_OVERRIDE_GFX_VERSION=11.0.0
export EDITOR=nvim 
export PATH=$PATH:$HOME/.local/bin:/opt/rocm/bin/:$VULKAN_SDK/x86_64/bin/

export PATH=$PATH:$HOME/.local/bin:/opt/rocm/bin/:$HOME/.virtualenvs/debugpy/bin/
export VULKAN_SDK=~/VulkanSDK/1.3.268.0
export PATH=$PATH:$VULKAN_SDK
export PATH=$PATH:~/.config/emacs/bin

export QT_QPA_PLATFORMTHEME=qt5ct
export SHELL=/usr/bin/zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
