#!/bin/bash

pushd "$(dirname "$0")/" > /dev/null

# Run to fix jumping cursor
# echo "blacklist wacom" | sudo tee -a /etc/modprobe.d/blacklist.conf
# sudo rmmod wacom

yay -S opentabletdriver
systemctl --user daemon-reload
systemctl --user enable opentabletdriver --now

popd

