#!/bin/bash

whatsapp-for-linux &
discord &
obs --minimize-to-tray &
sleep 2
obs-cli replaybuffer start --host 127.0.0.1 --password 1234 --port 4444 &
# steam &

:
