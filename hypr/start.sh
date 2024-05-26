#!/usr/bin/env bash

# initializing wallpaper daemon
swww init &
# setting wallpaper
# swww img ~/Wallpapers/image.png &

nm-applet --indicator &

waybar

dunst
