#!/bin/bash

# Query if cifs-utils is installed
if ! pacman -Qi cifs-utils &> /dev/null; then
    echo "cifs-utils is not installed. Installing..."
    sudo pacman -S cifs-utils
fi

sudo mkdir -p /mnt/WindowsShare
sudo mount.cifs //Patu/WindowsShare /mnt/WindowsShare -o rw,username=patu,file_mode=0777,dir_mode=0777


