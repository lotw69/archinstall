#!/bin/sh

WPHOME=$HOME/Pictures/Wallpapers
HLHOME=$HOME/.config/hypr/hyprpaper.conf

while true; do

	wallpaper="$(find -L $WPHOME -type f | shuf -n 1)"
	echo "ipc = off

	preload = $wallpaper

	wallpaper = eDP-1,$wallpaper
	wallpaper = HDMI-A-1,$wallpaper" > $HLHOME
	hyprpaper &

	sleep 900

	killall -9 hyprpaper
done
