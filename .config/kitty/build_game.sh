#!/bin/bash

# cd Projects/DEMO/build
cd /home/patu/Documents/Wyvern_Projects/RPG/build

if make -j32 config=release; then
    # read -p "Press [Enter]/Q to close..."
    exit 0 
else
    read -p "Press [Enter] or [Q] to close..."
    exit 1
fi

