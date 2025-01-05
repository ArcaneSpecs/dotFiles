#!/usr/bin/env bash
# wrappedhl
# Launch Hyprland with a simple wrapper

cd ~


# For x11 backend
#export QT_QPA_PLATFORM=xcb 

# For wayland backend
#export QT_WAYLAND_DISABLE_WINDOWDECORATION=1

# Fixes pavucontrol theme bug
#export GTK_THEME="MyCustom:dark"

# Variables
export _JAVA_AWT_WM_NONREPARENTING=1
export XCURSOR_SIZE=24

# Execute Hyprland
if [ -f /usr/local/bin/Hyprland ]; then
   exec /usr/local/bin/Hyprland >/dev/null 2>&1 
elif [ -f /usr/bin/Hyprland ]; then
   exec /usr/bin/Hyprland >/dev/null 2>&1 
fi
