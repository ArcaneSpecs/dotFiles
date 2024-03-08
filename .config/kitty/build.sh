#!/bin/bash

echo "Building in: $(pwd)"
cd build

# Check if ninja build file exists
if [ -f build.ninja ]; then
    ninja
    exit 0
fi

if make -j32 config=debug; then
# if make -j32 config=release; then
# if make -j32 config=production; then
    # read -p "Press [Enter]/Q to close..."
    exit 0 
else
    read -p "Press [Enter] or [Q] to close..."
    exit 1
fi

