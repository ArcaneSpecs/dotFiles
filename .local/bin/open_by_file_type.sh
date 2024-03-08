#!/bin/bash

# Parse the file type
file_type=$(file -b --mime-type "$1")

TEXT_EDITOR="nvim"
IMAGE_VIEWER="viewnior"
VIDEO_PLAYER="mpv"
FILE_MANAGER="ranger"

case "$file_type" in
    text/*)
        $TEXT_EDITOR "$1"
        ;;
    application/json)
        $TEXT_EDITOR "$1"
        ;;
    # image/*)
    #     $IMAGE_VIEWER "$1" &
    #     ;;
    video/*)
        $VIDEO_PLAYER "$1"
        ;;
    inode/directory)
        $FILE_MANAGER "$1"
        ;;
    *)
        echo "Unknown file type: $file_type"
        ;;
esac

# Parse the file extension
file_ext=$(echo "$1" | sed 's/.*\.//')

if [ "$file_ext" = "wproject" ]; then
    full_path=$(realpath "$1")
    ~/dev/simple_wyvern/Scripts/WyvernLauncher.sh "$full_path"&
    # kitty $TEXT_EDITOR "$1"&
fi

