#!/bin/bash

# https://wiki.archlinux.org/title/Samba

sudo systemctl enable samba


# this in /etc/samba/smb.conf
# [Public]
# path = /home/patu/PateShare
# browsable = yes
# writable = yes
# read only = no
# force crete mode = 0666
# force directory mode = 0777

