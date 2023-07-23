#!/bin/bash

wallpaper_dir=~/.config/Wallpapers/mp4s
mkdir -p $wallpaper_dir 

wallpaper_engine_dir=~/.local/share/Steam/steamapps/workshop/content/431960
find $wallpaper_engine_dir -type f -name "*.mp4" -exec mv {} ~/.config/Wallpapers/mp4s/ \;

