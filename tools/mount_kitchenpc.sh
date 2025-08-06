#!/bin/bash

if ! pacman -Qi cifs-utils &> /dev/null; then
    echo "cifs-utils is not installed. Installing..."
    sudo pacman -S cifs-utils
fi

sudo mkdir -p /mnt/KitchenPC
sudo mount.cifs //192.168.1.7/KitchenPC /mnt/KitchenPC -o rw,username=patu,file_mode=0777,dir_mode=0777

