#!/bin/bash

# Comment out keybinds line from config
sed '$s/^/#/' ~/.config/hypr/hyprland.conf > /tmp/hyprland_keybinds.conf && mv /tmp/hyprland_keybinds.conf ~/.config/hypr/hyprland.conf

