#!/bin/bash

echo "Building in: $(pwd)"
cd /home/patu/Documents/Wyvern_Projects/RPG/build

# if make WyvernServer -j32 config=debug; then
# # if make -j32 config=release; then
# # if make -j32 config=production; then
#     # read -p "Press [Enter]/Q to close..."
#
#     echo "Server built"
#     # exit 0 
# else
#     read -p "Press [Enter] or [Q] to close..."
#     exit 1
# fi

cd /home/patu/Documents/Wyvern_Projects/RPG/build

if make RPG -j32 config=debug; then
    # read -p "Press [Enter]/Q to close..."
    play -v 1.0 ~/.local/bin/sounds/success1.mp3 >/dev/null 2>&1
    exit 0 
else
    play -v 0.2 ~/.local/bin/sounds/fail4.wav >/dev/null 2>&1 &
    read -p "Press [Enter] or [Q] to close..."
    exit 1
fi

