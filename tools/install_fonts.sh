#!/bin/bash
cd ~/Downloads/
# unzip "*.zip" "*.ttf" "*.otf" -d ${HOME}/.fonts
# unzip "*.zip" "*.ttf" "*.otf" -d /usr/share/fonts/nerdfonts/newfonts/
unzip "*.zip" "*.ttf" "*.otf" -d /usr/share/fonts/nerdfonts/
sudo fc-cache -f -v

