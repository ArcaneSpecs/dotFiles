#!/bin/bash

# Update system
yes | sudo pacman -Syu
# Clear pacman cache
yes | sudo pacman -Scc

sudo pacman -S --needed base-devel git

mkdir -p ~/github

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

# Display manager / Login manager
sudo pacman -S sddm

# Hyprland deps
yay -S colord ffmpegthumbnailer gnome-keyring gtk-engine-murrine    \
imagemagick kvantum pamixer playerctl polkit-kde-agent qt5-quickcontrols          \
qt5-quickcontrols2 qt5-wayland qt6-wayland sway-bg ttf-font-awesome tumbler       \
ttf-jetbrains-mono ttf-icomoon-feather xdg-desktop-portal-hyprland-git xdotool    \
xwaylandvideobridge-cursor-mode-2-git cliphist qt5-imageformats qt5ct

# CLI 
yay -S btop cava neofetch noise-suppression-for-voice    \
rofi-lbonn-wayland-git rofi-emoji starship zsh viewnior

# PipeWire and OBS
yay -S obs-studio-rc ffmpeg-obs cef-minimal-obs-rc-bin    \
pipewire pipewire-alsa pipewire-audio pipewire-pulse      \
pipewire-jack wireplumber gst-plugin-pipewire pavucontrol

# Hyprland
yay -S hyprland-nvidia-git hyprpicker-git waybar-hyprland-git \
dunst nwg-look wf-recorder wlogout wlsunset

# yay -S hyprland-git polkit-kde-agent dunst grimblast rofi rofi-emoji       \
# wl-clipboard wf-recorder wlogout grimblast-git hyprpicker-git hyprpaper-git \
# xdg-desktop-portal-hyprland-git ffmpegthumbnailer tumbler wtype colord      \
# imagemagick swaylock-effects qt5-wayland qt6-wayland ripgrep waybar-hyprland-git

