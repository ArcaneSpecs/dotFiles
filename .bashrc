#
# ~/.bashrc
#

export BAKE_HOME=~/workspace/ns-allinone-3.29/bake
export PATH=$PATH:$BAKE_HOME:$BAKE_HOME/build/bin
export PYTHONPATH=$PYTHONPATH:$BAKE_HOME:$BAKE_HOME/build/lib

# Custom llvm to fix odin build for now
# NOTE: 22 not supported yet
# export PATH="$HOME/dev/llvm_22/bin":$PATH
# export PATH="$HOME/dev/llvm_21/bin":$PATH

# FIXME: Remove after debugging wyvern editor runtime
# export MALLOC_CHECK_=1 

# NOTE: Uncomment for niri window manager
# export DISPLAY=:1

# export DCMAKE_POLICY_VERSION_MINIMUM=3.5

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return
# PS1='[\u@\h \W]\$ '
alias javac="/usr/lib/jvm/java-25-openjdk/bin/javac"
alias fixaudio="systemctl --user restart pipewire wireplumber"

alias ncdu='gdu'
alias make='make -j32'
alias ls='eza --icons --color=auto'
alias grep='grep --color=auto'
alias ll='eza --icons --grid --all --color=auto'

# Git commands
alias rmgitcache="rm -r ~/.cache/git"
alias gm="git commit"
alias gs="git status"
alias gp="git push"
alias gpl="git pull"
alias lg="lazygit"
# alias grh="git reset --hard"

memscan()
{
    cd /home/patu/dev/pince
    source venv/bin/activate
    pince
}

# alias l.="/usr/bin/ls -GA | grep '^[ . . .]' | pr -t -6"
# alias l.="eza --all --icons -1 | grep '^( | | )'"
# alias l.="eza --all --icons -1"
# alias l.="eza --icons --all -1 --color=never | grep -E '^( | | | | | |󱆃 )\.' | column -t"
alias l.="eza --icons --all --color=never | grep -E '^\.' | column"

# sudo mount -t iso9660 -o ro,loop /path/to/file.iso /mount-point 
# alias mountiso="sudo mount -t iso9660 -o ro,loop"
# mkisofs -V "ARCHIVE_2013_07_27" -J -r -o isoimage.iso ./for_iso
# nameofiso.iso ./folder_to_iso
# alias mkiso="mkisofs -V 'ARCHIVE_2013_07_27'-J -r -o"
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
export GTK_THEME="MyCustom:dark"

alias of="onefetch"
alias krita="/var/lib/flatpak/exports/bin/org.kde.krita"
# alias yay=paru

export LUA_INIT='@/home/patu/.local/bin/lua/my_lua_functions.lua'

alias tablet="systemctl --user daemon-reload; systemctl --user enable opentabletdriver --now"
alias tabletinstall="yay -S opentabletdriver-git; systemctl --user daemon-reload; systemctl --user enable opentabletdriver --now; echo 'blacklist wacom' | sudo tee -a /etc/modprobe.d/blacklist.conf; sudo rmmod wacom"

# alias xfix="xinput --set-prop 10 'libinput Accel Speed' 0.0 && xset r rate 200 200"
alias xfix="xinput --set-prop 'pointer:''Logitech USB Receiver' 'libinput Accel Profile Enabled' 0, 1 && xinput --set-prop 'pointer:''Logitech USB Receiver' 'libinput Accel Speed' 0.0 && xset r rate 200 200"
alias sshfix="eval \$(ssh-agent -s) && ssh-add ~/.ssh/id_rsa && ssh-add ~/.ssh/id_ed25519"
alias make_all="make -j32 config=release& make -j32 config=debug& make -j32 config=production"

alias history_timestamps='HISTTIMEFORMAT="%Y-%m-%d %T "'
alias history='history -i'
alias hs='history -i'

alias code='/usr/bin/code'
alias kdenlive='flatpak run org.kde.kdenlive'
# alias flatpak\ run='flatpak run --env=QT_STYLE_OVERRIDE=kvantum --filesystem=xdg-config/Kvantum:ro'

alias ff='nvim "$(fzf)"'

alias memuse='function _memuse(){ cat /proc/$1/smaps | grep Rss | awk '\''{print $2}'\'' | awk '\''{s+=$1} END {printf "%.0f\n", s/1024}'\'' /dev/stdin; }; _memuse'

alias cmatrix="cmatrix -bas -C cyan"

# Try to attach to a tmux session, if not create one
alias ta="tmux attach || tmux new-session"

alias kubectl="minikube kubectl --"

alias spy="source venv/bin/activate"

# Alias to generate Wyvern Runtime makefiles
# INFO: (run in games build directory)
# Check the path to engine scripts dir depending what version you want to use
# This alias is useful for manually editing the premake file and not generating one using the engine
# (comes in handy when we are developing new links etc.)

gen_game() {
    local current_dir=$(pwd)
    local parent_dir=$(dirname "$current_dir")

    # If we are in build it still works
    if [[ "$current_dir" == *"/build"* ]]; then
        ~/dev/simple_wyvern/Scripts/Linux-GenGameMakefile.sh "$(realpath "$parent_dir")"
    else
        ~/dev/simple_wyvern/Scripts/Linux-GenGameMakefile.sh "$(realpath "$current_dir")"
    fi
}

# alias gen_game='~/dev/simple_wyvern/Scripts/Linux-GenGameMakefile.sh "$(pwd)"'
# Generate Wyvern Engine project files for a game project
alias gen_projects='~/dev/simple_wyvern/Scripts/Linux-GenerateProjectFiles.sh RPG.wproject'

# INFO: Finds process for given $1 argument and calcs the precise memory usage in bytes
mem() {
    # Grep ps aux output for process with $1 keyword
    ID="$(ps aux | grep -i -n --color "$1" | awk '{print $2}' | head --lines 1)"
    # Check memory usage for process (with ID)
    MEM="$(awk '{print $2}' /proc/$ID/statm)"
    # Calc the precise memory usage in bytes and make it easily readable
    printf "%'d bytes\n" $((MEM*4*1024))
}

# Outputs the last edited files (top one is the most recently edited file)
last_edit() {
    # Check if $1 exists and use it as the dir
    if [ $# -eq 1 ]; then
        find "$1" -type f -exec stat --format '%y %n' "{}" + | sort -nr | awk '{printf "%s | %.8s | %s\n", $1, $2, $4 }' | less
    else
        # If not, use the current dir instead
        # find . -type f -exec stat --format '%Y %n' "{}" + | sort -nr | awk '{print $2}' | less
        # NOTE: %.8ss to append 's' to the end to denote seconds
        find . -type f -exec stat --format '%y %n' "{}" + | sort -nr | awk '{printf "%s | %.8ss | %s\n", $1, $2, $4 }' | less
    fi
}

# Mounts phone to ~/MyPhone
mount_phone() {
    mkdir -p ~/MyPhone
    aft-mtp-mount ~/MyPhone
    if [ $? -ne 0 ]; then
        echo "Need to unmount first..."
        sudo umount -l ~/MyPhone
        aft-mtp-mount ~/MyPhone&
    fi

    # NOTE: This one doesn't really work for A52s
    # simple-mtpfs -v --device 1 ~/MyPhone
}

check_phone() {
    simple-mtpfs -l -v
}

# Compiles shaders in current dir using glslc (NOTE: compiles into CompiledShaders dir in cwd)
# comp_shaders()
comps()
{
    ~/dev/simple_wyvern/WyvernEditor/Assets/Shaders/Linux-BuildShaders.sh $(pwd)
}

# Debug wyvern engine editor with gdb
gdb_wyvern()
{
    pushd ~/Documents/Wyvern_Projects/RPG > /dev/null
    gdb --args ~/dev/simple_wyvern/build/bin/Debug-linux-x86_64/WyvernEditor/WyvernEditor "--project_root" "/home/patu/Documents/Wyvern_Projects/RPG" "--project_alias" "RPG" "--engine_assets" "/home/patu/dev/simple_wyvern/WyvernEditor" "--engine_root" "/home/patu/dev/simple_wyvern"
    popd > /dev/null
}

cloc_wyvern()
{
    pushd ~/dev/simple_wyvern > /dev/null
    cloc --exclude-list-file=./Wyvern/Source/Engine/Core/MiniAudio.h Wyvern/Source WyvernEditor/Source Runtime/Source WyvernServer/Source Scripts Tools/WyvernVersionSelector Tools/DependencySetup/Setup/main.py Tools/DependencySetup/Setup WyvernEditor/Assets/Shaders/*.frag WyvernEditor/Assets/Shaders/*.vert WyvernEditor/Assets/Shaders/*.glslh
    # Tools/Blender 
    popd > /dev/null
}

cloc_odin_wyvern()
{
    pushd ~/dev/WyvernEngineOdin > /dev/null
    cloc *.sh *.bat engine/source/* source/* tools/project_generator/project_generator.odin tools/code_generator scripts projects
    # Tools/Blender 
    popd > /dev/null
}

# Run stable diffusion webui
sd()
{
    cd /github_dir/stable-diffusion-webui
    brave-nightly "http://127.0.0.1:7860/?__theme=dark" &
    source venv/bin/activate
    ./webui.sh --no-half --disable-nan-check
}

comfy()
{
    cd /github_dir/ComfyUI
    brave-nightly "http://127.0.0.1:8188"
    ./run.sh
}

# Run wow exe
wow()
{
    WINEPREFIX=~/.wine wine "/mnt/2TB/Vault/wow_ps/1.12.1/World of Warcraft/Wow.exe"

}

hyprland_logs()
{
    # watch -n 0.1 "cat "/run/user/1000/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/hyprland.log" | grep -v "efresh" | grep "rule" | tail -n 40"
    watch -n 0.1 'cat "/run/user/1000/hypr/$(echo $HYPRLAND_INSTANCE_SIGNATURE)/hyprland.log" | tail -n 60'
}

ue5()
{
    PROJECT_FILE=$(printf "%s/%s" "$(pwd)" "$1")
    # echo project file is $PROJECT_FILE
    /github_dir/UnrealEngine/Engine/Binaries/Linux/UnrealEditor "$PROJECT_FILE"
}

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

# For conda
export CRYPTOGRAPHY_OPENSSL_NO_LEGACY=1

export XDG_CONFIG_HOME=$HOME/.config

nuke()
{
    if [ -d ../build ]; then
        cd ..
        rm -rf build
        mkdir build
        cd build
        ../Scripts/Linux-GenProjects.sh
        /usr/bin/make -j32 2>build.log
    fi 
}

alias ses='tmux-sessionizer'

nsights()
{
    export LD_PRELOAD=/opt/nsight-graphics/target/linux-desktop-nomad-x64/libNvda.Graphics.Interception.so:$LD_PRELOAD
    ngfx-ui 
}
# Shorter alias for nsights
alias ns=nsights

resolve()
{
    cd /opt/resolve/bin
    # export LD_PRELOAD="/usr/lib/libgio-2.0.so /usr/lib/libgmodule-2.0.so /usr/lib/libglib-2.0.so" 
    export LD_PRELOAD="/usr/lib/libgio-2.0.so /usr/lib/libgmodule-2.0.so /usr/lib/libglib-2.0.so" 
    /opt/resolve/bin/resolve
}

backup_chat()
{
    TIME=$(date +"%d-%-m-%y_%H-%M-%S")
    cp /home/patu/.local/share/nvim/lazy/tabnine-nvim/chat_state.json ~/.config/tabnine_chat_history/chat_$TIME.json
}


# dlls_no_less()
# {
#     cat /proc/"$1"/maps | awk '{print $6}' | grep '\.so' | sort | uniq 
# }
#
# dlls()
# {
#     dlls_no_less "$1" | less
# }

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

# export VK_INSTANCE_LAYERS=VK_LAYER_live_introspection

export PAGER=less
# export PAGER=bat

export XCURSOR_THEME=Adwaita
export XCURSOR_SIZE=24

export HIP_VISIBLE_DEVICES=0
export HSA_OVERRIDE_GFX_VERSION=11.0.0

export FBX_DIR=~/github/ozz-animation/fbx

export EDITOR=nvim 
alias nvimm='nvim -m'
# export VULKAN_SDK=~/VulkanSDK/1.3.275.0
# export VULKAN_SDK=~/VulkanSDK/1.4.321.1
export VULKAN_SDK=~/VulkanSDK/1.4.335.0
# export PATH=$HOME/.local/bin:/opt/rocm/bin:${VULKAN_SDK}/x86_64/bin:/usr/lib/odin_nightly:$PATH
export PATH=$HOME/.local/bin:/opt/rocm/bin:${VULKAN_SDK}/x86_64/bin:/usr/lib/odin:$PATH
export PATH=/github_dir/emsdk:/github_dir/emsdk/upstream/emscripten:$PATH
export PATH=$PATH:~/AppImages
export ROCM_HOME=/opt/rocm

export PATH=$PATH:$HOME/.local/bin:/opt/rocm/bin:$HOME/.virtualenvs/debugpy/bin
export PATH=$PATH:$VULKAN_SDK
export PATH=$PATH:~/.config/emacs/bin

export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_STYLE_OVERRIDE="kvantum"
# export QT_STYLE_OVERRIDE="Darkly"
export QTDIR="/home/patu/Qt"
export QT_PLUGIN_PATH=/usr/lib/qt6/plugins:$QT_PLUGIN_PATH
# export QT_PLUGIN_PATH=/home/patu/nvidia/NVIDIA-Nsight-Graphics-2024.2/host/linux-desktop-nomad-x64/Plugins
export LD_LIBRARY_PATH=/usr/lib/qt6/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/usr/lib:/usr/lib32:$LD_LIBRARY_PATH
# export PYTHONPATH=/usr/lib/krita-python-libs/krita:$PYTHONPATH

export PYTHONSTARTUP=~/.local/bin/python/start.py
export PYTHONPATH=$PYTHONPATH:~/.local/bin/python/

# LD_PRELOAD=/home/patu/nvidia/NVIDIA-Nsight-Graphics-2021.5/target/linux-desktop-nomad-x64/libNomad.Injection.so NV_TPS_LAUNCH_TOKEN="Frame Debugger" ./start_demo

# Qt plugins search path: /home/patu/nvidia/NVIDIA-Nsight-Graphics-2022.6/host/linux-desktop-nomad-x64
export XDG_DATA_DIRS=/home/patu/nvidia/NVIDIA-Nsight-Graphics-2022.6/target/linux-desktop-nomad-x64/NomadVulkanLayer:$XDG_DATA_DIRS

export SHELL=/usr/bin/zsh

# NOTE: Uncomment for C++ Wyvern Engine editor neovim support
# if [[ $TERM == "xterm-kitty" ]]; then
#     # echo "kitty window id: " $KITTY_WINDOW_ID
#     # Neovim sockets for wyvern
#     # FIXME: Why can't we run this on multiple neovim instances
#     # export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket # NOTE: Comment out for Wyvern Editor neovim support
#     # source ~/dev/WyvernLauncher/NeovimServer/venv/bin/activate
#     source ~/dev/simple_wyvern/Tools/DependencySetup/venv/bin/activate
# fi

# NOTE: uncomment for conda
# # Source miniconda
# [ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
#
# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
# __conda_setup="$('/opt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
# if [ $? -eq 0 ]; then
#     eval "$__conda_setup"
# else
#     if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
#         . "/opt/miniconda3/etc/profile.d/conda.sh"
#     else
#         export PATH="/opt/miniconda3/bin:$PATH"
#     fi
# fi
# unset __conda_setup
# <<< conda initialize <<<
