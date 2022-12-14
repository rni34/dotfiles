#!/bin/bash

#########################################################
#
# PAMUTE
#
# Mute/Unmute individual Pulseaudio's streams using Rofi.
#
# Requires:
#  - pactl
#  - gawk
#  - rofi
#
# Configure your rofi options here:
#

ROFI_OPTIONS="-p 'Audio Streams: ' -font 'DejaVu Sans Mono 12' -width 600"

#
#########################################################

pactl list sink-inputs | awk -v rofi_cmd="rofi -dmenu -format i $ROFI_OPTIONS" '
	BEGIN {	item = 1 }

	/^Sink Input/ {
		if (item in sinks)
			item++
		split($0, result, "#")
		sinks[item]["sink"] = result[2]
		next
	}

	/application\.name/ {
		split($0, result, "\"")
		sinks[item]["name"] = result[2]
		next
	}

	/application\.process\.binary/ {
		split($0, result, "\"")
		sinks[item]["binary"] = result[2]
		next
	}

	/Mute:/ {
		sinks[item]["muted"] = ($2 == "yes" ? 1 : 0)
		next
	}

	END {
		if (length(sinks) == 0) {
			print("NO STREAMS FOUND") | rofi_cmd
			exit
		}
		
		print("UNMUTE ALL") |& rofi_cmd
		
		for (item in sinks) {
			muted = (sinks[item]["muted"] ? "\xf0\x9f\x94\x87" : "\xf0\x9f\x94\x8a")
			print(muted "  " sinks[item]["name"] " (" sinks[item]["binary"] ")") |& rofi_cmd
		}
		
		close(rofi_cmd, "to")
		rofi_cmd |& getline selected
		
		if (selected != "") {
			if (selected == 0) {
				for (item in sinks) {
					system("pactl set-sink-input-mute " sinks[item]["sink"] " 0")
				}
			} else {
				system("pactl set-sink-input-mute " sinks[selected]["sink"] " toggle")
			}
		}
	}
'
