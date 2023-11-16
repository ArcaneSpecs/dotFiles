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
alias l.="eza --icons --all -1 --color=never | grep -E '^( | | | | | |󱆃 )\.' | column -t"

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
alias fix="systemctl --user restart pipewire; systemctl --user daemon-reload"

alias tablet="systemctl --user daemon-reload; systemctl --user enable opentabletdriver --now"
alias tabletinstall="yay -S opentabletdriver-git; systemctl --user daemon-reload; systemctl --user enable opentabletdriver --now; echo 'blacklist wacom' | sudo tee -a /etc/modprobe.d/blacklist.conf; sudo rmmod wacom"

# alias xfix="xinput --set-prop 10 'libinput Accel Speed' 0.0 && xset r rate 200 200"
alias xfix="xinput --set-prop 'pointer:''Logitech USB Receiver' 'libinput Accel Profile Enabled' 0, 1 && xinput --set-prop 'pointer:''Logitech USB Receiver' 'libinput Accel Speed' 0.0 && xset r rate 200 200"
alias sshfix="eval \$(ssh-agent -s) && ssh-add ~/.ssh/id_rsa && ssh-add ~/.ssh/id_ed25519"
alias make_all="make -j32 config=release& make -j32 config=debug& make -j32 config=production"


export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

alias nuke="cd .. && rm -rf build && mkdir build && cd build && ../Scripts/Linux-GenProjects.sh && make -j32"

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

export QT_QPA_PLATFORMTHEME=qt5ct
export SHELL=/usr/bin/zsh

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

