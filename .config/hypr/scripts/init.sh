#!/bin/bash

# flatpak run com.github.wwmm.easyeffects --hide-window &
flatpak run com.github.wwmm.easyeffects --gapplication-service &
otd-daemon &
# whatsapp-for-linux &
whatsapp-electron &
discord &
# obs --minimize-to-tray &
flatpak run com.obsproject.Studio --minimize-to-tray &
# easyeffects &
# Telegram &

# pavucontrol &
sleep 4
obs-cmd replay start
# obs-cli replaybuffer start --host 192.168.1.82 --password teppo --port 4455 &
# steam &

# Mount phone to MyPhone at startup
aft-mtp-mount ~/MyPhone &

