#!/bin/bash

# cd Projects/DEMO/build
# cd /home/patu/dev/simple_wyvern/Projects/RPG/build
cd /home/patu/Documents/Wyvern_Projects/RPG/build

# if make -j32 config=release; then
# if make -j32 config=production; then
if make -j32 config=debug; then
    # read -p "Press [Enter]/Q to close..."
    exit 0 
else
    read -p "Press [Enter] or [Q] to close..."
    exit 1
fi

