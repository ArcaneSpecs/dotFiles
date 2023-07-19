#!/bin/bash

pushd "$(dirname "$0")/" > /dev/null

# Update system
yes | sudo pacman -Syu

# Clear pacman cache
yes | sudo pacman -Scc

# Change shell to zsh
chsh -s /bin/zsh

yes | sudo pacman -S --needed base-devel git wget tar zip unzip sddm-git pcmanfm nodejs \
arc-gtk-theme arc-icon-theme 

mkdir -p ~/github
git clone --depth 1 --recursive https://github.com/marlonrichert/zsh-autocomplete.git ~/github/zsh-autocomplete

# Install fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/Meslo.zip -P ~/Downloads
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/InconsolataGo.zip -P ~/Downloads

sudo mkdir -p /usr/share/fonts/nerdfonts
cd ~/Downloads
sudo unzip -o "*.zip" "*.ttf" "*.otf" -d /usr/share/fonts/nerdfonts/
sudo fc-cache -f -v

# Download QT themes
# wget https://ocs-dl.fra1.cdn.digitaloceanspaces.com/data/files/1687532960/Bluish-Dark-Kvantum.tar.gz?response-content-disposition=attachment%3B%2520Bluish-Dark-Kvantum.tar.gz&X-Amz-Content-Sha256=UNSIGNED-PAYLOAD&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=RWJAQUNCHT7V2NCLZ2AL%2F20230713%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230713T095448Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Signature=bdda392ec449548040287520d919f82aca056a512b1250077ebaf032f0dd21e0 -P ~/Downloads/

# Check if yay is installed
if yay --version &> /dev/null; then
    echo "yay is already installed"
else
    echo "yay is not installed"
    # Install yay
    git clone https://aur.archlinux.org/yay.git ~/github/yay
    cd ~/github/yay
    makepkg -si
    yay --version
fi


# Hyprland deps
yes | yay -S swaybg colord ffmpegthumbnailer gnome-keyring gtk-engine-murrine     \
imagemagick kvantum pamixer playerctl polkit-kde-agent qt5-quickcontrols          \
qt5-quickcontrols2 qt5-wayland qt6-wayland sway-bg ttf-font-awesome tumbler       \
ttf-jetbrains-mono ttf-icomoon-feather xdg-desktop-portal-hyprland-git xdotool    \
xwaylandvideobridge-cursor-mode-2-git cliphist qt5-imageformats qt5ct

# Set kvantum theme
# kvantummanager --set Fluent-Dark 
kvantummanager --set Bluish-Dark-Kvantum


# CLI 
yes | yay -S btop cava neofetch noise-suppression-for-voice    \
dunst rofi-lbonn-wayland-git rofi-emoji starship zsh viewnior ripgrep ncspot \
htop ark ncdu swww wofi

# PipeWire 
yes | yay -S pipewire pipewire-alsa pipewire-audio pipewire-pulse      \
pipewire-jack wireplumber gst-plugin-pipewire pavucontrol

# OBS
#yay -S obs-studio-rc ffmpeg-obs cef-minimal-obs-rc-bin 

# Hyprland
yes | yay -S hyprland-nvidia-git hyprpicker-git waybar-hyprland-git \
nwg-look wf-recorder wlsunset


# yay -S hyprland-git polkit-kde-agent dunst grimblast rofi rofi-emoji       \
# wl-clipboard wf-recorder wlogout grimblast-git hyprpicker-git hyprpaper-git \
# xdg-desktop-portal-hyprland-git ffmpegthumbnailer tumbler wtype colord      \
# imagemagick swaylock-effects qt5-wayland qt6-wayland ripgrep waybar-hyprland-git

popd
