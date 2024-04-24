#!/bin/bash

echo "Building in: $(pwd)"
cd build

if make WyvernServer -j32 config=debug; then
# if make -j32 config=release; then
# if make -j32 config=production; then
    # read -p "Press [Enter]/Q to close..."

    echo "Server built"
    # exit 0 
else
    read -p "Press [Enter] or [Q] to close..."
    exit 1
fi

cd /home/patu/Documents/Wyvern_Projects/RPG/build

if make -j32 config=debug; then
    # read -p "Press [Enter]/Q to close..."
    exit 0 
else
    read -p "Press [Enter] or [Q] to close..."
    exit 1
fi

