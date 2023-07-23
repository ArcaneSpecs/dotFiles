#!/bin/bash

pushd "$(dirname "$0")/" > /dev/null

# Run to fix jumping cursor
# echo "blacklist wacom" | sudo tee -a /etc/modprobe.d/blacklist.conf
# sudo rmmod wacom

# https://opentabletdriver.net/Wiki/FAQ/Linux#artist-mode
# Run these to fix artist mode

# 1. Create an override file 
# Opens with whatever program is set to $EDITOR
# systemctl --user edit opentabletdriver.service

# 2. Add this block below the first 2 lines of the file, then save and exit 
# [Service]
# Environment=WAYLAND_DISPLAY=:0
# 3. Add this block below the first 2 lines of the file, then save and exit 
# Reload the systemd user daemon
# systemctl --user daemon-reload
# Start the OpenTabletDriver daemon service (restarts if already running)
# systemctl --user restart opentabletdriver.service

yay -S opentabletdriver
systemctl --user daemon-reload
systemctl --user enable opentabletdriver --now

popd

