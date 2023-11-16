#!/bin/bash

cd build

if make -j32 config=release; then
    # read -p "Press [Enter]/Q to close..."
    exit 0 
else
    read -p "Press [Enter] or [Q] to close..."
    exit 1
fi
