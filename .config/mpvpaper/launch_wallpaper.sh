#!/bin/bash
# mpvpaper '*' ~/Downloads/wallpapers/dance.mp4 -o "--no-audio"
mpvpaper -o "no-audio --loop-playlist shuffle" '*' ~/Downloads/wallpapers/ -v
# mpvpaper -o "no-audio --loop-playlist shuffle" DP-1 https://www.youtube.com/watch?v=5SgN5lvWZwQ&list=RDMM5SgN5lvWZwQ&start_radio=1
# mpvpaper -o "no-audio --loop-playlist shuffle" DP-1 www.url/to/playlist

# mpvpaper -o "input-ipc-server=/tmp/mpv-socket" DP-1 /path/to/video

# echo 'cycle pause' | socat - /tmp/mpv-socket

