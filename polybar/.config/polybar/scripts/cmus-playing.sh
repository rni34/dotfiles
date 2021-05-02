#!/bin/bash

PLAYING=$(cmus-remote -C status | grep "tag title" | cut -d ' ' -f3-)

if [[ "$PLAYING" == "MEGALOBOX" ]]; then
	echo "FUCKING HYPE SONG"
fi

echo "$PLAYING"
