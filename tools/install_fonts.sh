#!/bin/bash
cd ~/Downloads/
# unzip "*.zip" "*.ttf" "*.otf" -d ${HOME}/.fonts
# unzip "*.zip" "*.ttf" "*.otf" -d /usr/share/fonts/nerdfonts/newfonts/
sudo unzip "*.zip" "*.ttf" "*.otf" -d /usr/share/fonts/nerdfonts/
sudo fc-cache -f -v

# Fix glyphs
sudo pacman -Syu $(sudo pacman -Ssq ttf-)

