#!/bin/bash

grim -g "$(slurp -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | awk '{print $4}' | sed -n '2p' | awk -F '[,()]' '{max = $2; printf "ImVec4(%.1f / max, %.1f / max, %.1f / max, 1.0f)\n", $2, $3, $4}' | wl-copy

# echo "(99,109,109)" | awk -F '[,()]' '{max = $2; printf "ImVec4(%.1f / max, %.1f / max, %.1f / max, 1.0f)\n", $2, $3, $4}'


