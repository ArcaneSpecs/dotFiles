#!/bin/bash

# grim -g "$(slurp -p)" -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | awk '{print $4}' | sed -n '2p' | awk -F '[,()]' '{max = $2; printf "ImVec4(%.1f / max, %.1f / max, %.1f / max, 1.0f)\n", $2, $3, $4}' | wl-copy
# hyprpicker | tr -d '\n' | wl-copy

# echo "(99,109,109)" | awk -F '[,()]' '{max = $2; printf "ImVec4(%.1f / max, %.1f / max, %.1f / max, 1.0f)\n", $2, $3, $4}'
hyprpicker | tr -d '\n' | awk -F '' '{printf "ImVec4(%.1f / 255.f, %.1f / 255.f, %.1f / 255.f, 1.0f)\n", strtonum("0x"$2$3), strtonum("0x"$4$5), strtonum("0x"$6$7)}' | wl-copy
#273E43
