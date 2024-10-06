#!/usr/bin/env bash

# initializing wallpaper daemon
swww init &
# setting wallpaper
swww img ~/Pictures/Wallpapers/sunset-mountain-beautiful-digital-art-scenery-4k-wallpaper-uhdpaper.com-183@1@n.jpg &

wal -i "~/Pictures/Wallpapers/sunset-mountain-beautiful-digital-art-scenery-4k-wallpaper-uhdpaper.com-183@1@n.jpg" &

nm-applet --indicator &

waybar &

dunst &

swayidle -w timeout 150 'swaylock -f' timeout 200 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
