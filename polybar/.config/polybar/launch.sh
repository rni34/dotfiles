#!/bin/bash

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

polybar -c ~/.config/polybar/config top &

echo "Bars launched"

killall -q nextcloud
sleep 3
nextcloud &
