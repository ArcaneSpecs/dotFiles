#!/bin/bash

# Check if pulsemixer is running, if not start it
if ! pgrep -f pulsemixer > /dev/null; then
    pulsemixer &> /dev/null &
fi

# Get volume information
volume=$(pulsemixer --get-volume | awk '{print $1}')
muted=$(pulsemixer --get-mute)

# 󰕿
# 
# 󰖀
# 
# 󰕾

# Format the output
if [ "$muted" == 1 ]; then
    echo "󰝟 MUTED"
else
    if [ "$volume" -ge 85 ]; then
        echo "+ $volume%"
    elif [ "$volume" -ge 70 ]; then
        echo "  $volume%"
    elif [ "$volume" -ge 55 ]; then
        echo "+ $volume%"
    elif [ "$volume" -ge 35 ]; then
        echo "  $volume%"
    elif [ "$volume" -ge 20 ]; then
        echo "󰖀  $volume%"
    else
        echo "󰕿  $volume%"
    fi
    # echo " seppo"
fi


