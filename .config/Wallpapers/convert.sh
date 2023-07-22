#!/bin/bash

# Convert gif to series of png frames
# convert -coalesce space.gif space%04d.png

# Take the first argument as the input file and strip the extension
# INPUT_FILE=$1
# FILENAME=${INPUT_FILE%.*}
mkdir -p mp4s

files=()
for VAR in *.mp4 
do
    if [[ -f "$VAR" ]] 
    then
        files+=("$VAR")
        echo "Converting: $VAR"
        # sleep 4
        ffmpeg -i $VAR ${VAR%.*}.gif
        mv $VAR mp4s/
    fi
done
# for VAR in "${files[@]}"
# do

# done
# if [ $1 == "*" ]; then

    # ffmpeg -i $INPUT_FILE $FILENAME.gif
# else
    # Convert mp4 to gif
    # ffmpeg -i $INPUT_FILE $FILENAME.gif
# fi


