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
cp -r ~/.local/bin .local

# Files in .config
cp ~/.xinitrc .
cp ~/.Xresources .
cp ~/.zshrc .
cp ~/.bashrc .

# System files to make hyprland work on nvidia GPU
cp /etc/mkinitcpio.conf .config/nvidia/mkinitcpio.conf 
cp /etc/modprobe.d/nvidia.conf .config/nvidia/nvidia.conf
cp /etc/locale.conf . 

popd > /dev/null

