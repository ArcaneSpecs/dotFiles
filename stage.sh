#!/bin/bash

pushd "$(dirname "$0")/" > /dev/null

# Directories in .config
cp -r ~/.config/kitty .config
cp -r ~/.config/hypr .config
cp -r ~/.config/waybar .config
cp -r ~/.config/qt5ct .config 
cp -r ~/.config/qt6ct .config 
cp -r ~/.config/nvim .config 
cp -r ~/.config/Kvantum .config
cp -r ~/.config/rofi .config
cp -r ~/.config/firefox .config

# Just files but not the mp4s
find ~/.config/Wallpapers -maxdepth 1 -type f -exec cp {} .config/Wallpapers \;
# cp -r ~/.config/Wallpapers .config

# cp -r ~/.local/bin .local
cp ~/.local/bin/screensht .local/bin
cp ~/.local/bin/wrappedhl.sh .local/bin
cp ~/.local/bin/wallpaper .local/bin
cp ~/.local/bin/wallpaperselect .local/bin

# Autostart
cp -r ~/.config/autostart/ .config

# Files in .config
cp ~/.xinitrc .
cp ~/.Xresources .
cp ~/.zshrc .
cp ~/.bashrc .

# System files to make hyprland work on nvidia GPU
# cp /etc/mkinitcpio.conf .config/nvidia/mkinitcpio.conf 
# cp /etc/modprobe.d/nvidia.conf .config/nvidia/nvidia.conf

cp /etc/locale.conf . 

popd > /dev/null

