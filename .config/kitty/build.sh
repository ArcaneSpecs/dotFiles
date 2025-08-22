#!/bin/bash

echo "Building in: $(pwd)"

if [ -d build ]; then
    cd build
# else
#     mkdir build
fi

# /home/patu/dev/WyvernEngineOdin/build_hot_reload.sh

# Check if ninja build file exists
if [ -f build.ninja ]; then
    ninja
    exit 0
fi

sound_volume=0.00
error_volume=0.00

function success()
{
    # read -p "Press [Enter]/Q to close..."
    # <&- in the end to not open file at all so we can use read -p
    play -v $sound_volume ~/.local/bin/sounds/success1.mp3 >/dev/null 2>&1<&-
    echo "Done!"
    # exit 0 
}

function fail()
{
    # <&- in the end to not open file at all so we can use read -p
    play -v $error_volume ~/.local/bin/sounds/fail4.wav >/dev/null 2>&1<&-
    read -p "Press [Enter] or [Q] to close..."
    exit 1
}

CURRENT_DIR=$(basename "$(dirname "$PWD")")

BUILD_COMMAND="make -j32" # Use this for normal projects
# BUILD_COMMAND="make Editor -j32" # Just to test EditorRuntime 
if [ "$CURRENT_DIR" = "simple_wyvern" ]; then
    # Build the editor dll
    BUILD_COMMAND="make -j32 config=debug Wyvern WyvernEditor EditorLayer"
    LAYER_COMMAND="make WyvernEditor -j32 config=debug"
fi
if [ "$CURRENT_DIR" = "WyvernEngineOdin" ]; then
    # Build the editor dll
    BUILD_COMMAND="/home/patu/dev/WyvernEngineOdin/build_hot_reload.sh"
fi

if [ "$CURRENT_DIR" = "RPG" ]; then
    # Build the editor dll
    BUILD_COMMAND="make -j32 config=debug WyvernGame WyvernGameRuntime RPG"
fi
if [ "$CURRENT_DIR" = "WyvernEngineDev" ]; then
    BUILD_COMMAND="make WyvernEditor -j32 config=debug"
fi

if $BUILD_COMMAND; then
    success
    # mkdir -p /home/patu/dev/simple_wyvern/build/bin/Debug-linux-x86_64/WyvernEditor/hot
    # cp /home/patu/dev/simple_wyvern/build/bin/Debug-linux-x86_64/WyvernEditor/libWyvernEditor.so /home/patu/dev/simple_wyvern/build/bin/Debug-linux-x86_64/WyvernEditor/hot/libWyvernEditor.so

    # FIXME: Take this copy out when hot reload works with whole engine
    # cp /home/patu/dev/simple_wyvern/build/bin/Debug-linux-x86_64/Wyvern/libWyvern.so /home/patu/dev/simple_wyvern/build/bin/Debug-linux-x86_64/Wyvern/hot/libWyvern.so

    if [ "$CURRENT_DIR" = "RPG" ]; then
        cd "/home/patu/dev/simple_wyvern/build"

        BUILD_COMMAND="make -j32 config=debug Wyvern"
        if $BUILD_COMMAND; then
            success
        else
            fail
        fi
    fi

    # Also build the runtime executable if needed
    # BUILD_COMMAND="make WyvernEditorRuntime -j32 config=debug"
    # if $BUILD_COMMAND; then
    #     success
    # fi

    # read -p "Press [Enter] or [Q] to close..."
    exit 0
else
    fail
    exit 1
fi

# BUILD_PID=$!
#
# if $LAYER_COMMAND & then
#     success
#     # mkdir -p /home/patu/dev/simple_wyvern/build/bin/Debug-linux-x86_64/WyvernEditor/hot
#     # cp /home/patu/dev/simple_wyvern/build/bin/Debug-linux-x86_64/WyvernEditor/libWyvernEditor.so /home/patu/dev/simple_wyvern/build/bin/Debug-linux-x86_64/WyvernEditor/hot/libWyvernEditor.so
#
#     # read -p "Press [Enter] or [Q] to close..."
#     exit 0
# else
#     fail
#     exit 1
# fi
# LAYER_PID=$!
#
# wait $BUILD_PID
# BUILD_STATUS=$?
#
# wait $LAYER_PID
# LAYER_STATUS=$?

