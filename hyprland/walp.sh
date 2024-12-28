#!/bin/sh

while true; do
	wallpaper="$(find -L "/home/erik/Pictures/Wallpapers" -type f | shuf -n 1)"
	echo "ipc = off"

	preload = $wallpaper

	wallpaper = eDP-1,$wallpaper
	wallpaper = HDMI-A-1,$wallpaper" > "/home/erik/.config/hypr/hyprpaper.conf"
	hyprpaper &

	sleep 900

	killall -9 hyprpaper
done
