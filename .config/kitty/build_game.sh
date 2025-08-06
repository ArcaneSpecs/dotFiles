#!/bin/bash

# cd Projects/DEMO/build
# cd /home/patu/dev/simple_wyvern/Projects/RPG/build
cd /home/patu/Documents/Wyvern_Projects/RPG/build

# if make -j32 config=release; then
# if make -j32 config=production; then
# INFO: Currently we just want to build for editor
# if make RPG -j32 config=debug; then
# if make Runtime -j32 config=debug 2>build.log; then
if make Runtime -j32 config=debug; then
# if make -j32 config=debug; then
    # read -p "Press [Enter]/Q to close..."
    play -v 1.0 ~/.local/bin/sounds/success1.mp3 >/dev/null 2>&1
    exit 0 
else
    play -v 0.2 ~/.local/bin/sounds/fail4.wav >/dev/null 2>&1 &
    read -p "Press [Enter] or [Q] to close..."
    exit 1
fi

