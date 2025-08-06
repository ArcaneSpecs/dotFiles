#!/bin/bash


while [ 1 ]; do
    sleepTime=9
    pos=$(xdotool getmouselocation --shell)

    notify-send "Mouse Position" \
                "${pos}" \
                -t $sleepTime 
    sleep 0.001
done


