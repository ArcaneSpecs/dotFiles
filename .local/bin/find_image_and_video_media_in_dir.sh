#!/bin/bash

directory=$1
output_dir=$2

if [ $# -ne 2 ]; then
    echo "Usage: $0 <directory_to_find> <output_dir>"
    exit 1
fi

# find "$directory" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.mp4" -o -iname "*.mov" -o -iname "*.avi" -o -iname "*.mkv" \) -print0 | while read -d $'\0' file
#
# do
#     echo "$file"
# done

find "$directory" -type f -print0 | while IFS= read -r -d $'\0' file; do
    # Use the 'file' command to determine the file type
    file_type=$(file -b --mime-type "$file")

    # Check if the file type is video or image
    if [[ $file_type == video/* || $file_type == image/* ]]; then
        # echo "$file_type file: $file"
        # echo the full path
        cp "$file" "$output_dir"
        # echo "$file"
        # You can add additional actions here, such as copying or processing the file
    fi
done
