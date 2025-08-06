#!/bin/bash

LAUNCH=www.youtube.com

killall wofi
killall rofi

if [ $# -gt 0 ]; then
    LAUNCH=$1
    # echo "launching custom"
fi

ID=$(apg -n 1 -m 32 -x 32)
wofi_command="wofi --show dmenu -i --prompt URL"

LAUNCH=$(${wofi_command})

if [ "$LAUNCH" = "" ]; then
    exit 0
fi

echo Opening: www.$LAUNCH.com ...

if [ "$LAUNCH" = "youtube" ]; then
    /opt/brave.com/brave-nightly/brave-browser-nightly --profile-directory=Default --app-id=agimnkijcaahngcdmfeangaknmldooml "--app-launch-url-for-shortcuts-menu-item=https://www.$LAUNCH.com" # Youtube id 
elif [ "$LAUNCH" = "twitter" ]; then
    /opt/brave.com/brave-nightly/brave-browser-nightly --profile-directory=Default --app-id=lodlkdfmihgonocnmddehnfgiljnadcf "--app-launch-url-for-shortcuts-menu-item=https://www.$LAUNCH.com" # Twitter id
elif [ "$LAUNCH" = "x" ]; then
    /opt/brave.com/brave-nightly/brave-browser-nightly --profile-directory=Default --app-id=lodlkdfmihgonocnmddehnfgiljnadcf "--app-launch-url-for-shortcuts-menu-item=https://www.$LAUNCH.com" # Twitter id
elif [ "$LAUNCH" = "github" ]; then
    /opt/brave.com/brave-nightly/brave-browser-nightly --profile-directory=Default --app-id=mjoklplbddabcmpepnokjaffbmgbkkgg "--app-launch-url-for-shortcuts-menu-item=https://www.$LAUNCH.com" # Github id
else
    /opt/brave.com/brave-nightly/brave-browser-nightly --profile-directory=Default "--app-launch-url-for-shortcuts-menu-item=$LAUNCH" # Random id
fi

# /opt/brave.com/brave-nightly/brave-browser-nightly --profile-directory=Default --app-id=$ID "--app-launch-url-for-shortcuts-menu-item=$LAUNCH"

