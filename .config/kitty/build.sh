#!/bin/bash

echo "Building in: $(pwd)"
cd build

# Check if ninja build file exists
if [ -f build.ninja ]; then
    ninja
    exit 0
fi

# if make -j32 config=release; then
# if make -j32 config=production; then
# if make -j32 config=debug; then
# if make WyvernEditor -j32 config=debug; then

CURRENT_DIR=$(basename "$(dirname "$PWD")")

BUILD_COMMAND="make -j32"
if [ "$CURRENT_DIR" = "simple_wyvern" ]; then
    BUILD_COMMAND="make WyvernEditor -j32 config=debug"
fi
if [ "$CURRENT_DIR" = "WyvernEngineDev" ]; then
    BUILD_COMMAND="make WyvernEditor -j32 config=debug"
fi
if $BUILD_COMMAND; then
    # read -p "Press [Enter]/Q to close..."
    exit 0 
else
    read -p "Press [Enter] or [Q] to close..."
    exit 1
fi

