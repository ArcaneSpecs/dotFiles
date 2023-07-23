#!/bin/bash

sudo pacman -S cifs-utils
sudo mkdir -p /mnt/WindowsShare
sudo mount.cifs //Patu/WindowsShare /mnt/WindowsShare -o rw,username=patu,file_mode=0777,dir_mode=0777


