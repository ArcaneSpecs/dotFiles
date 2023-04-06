#!/bin/bash
unzip "*.zip" "*.ttf" "*.otf" -d ${HOME}/.fonts
sudo fc-cache -f -v

