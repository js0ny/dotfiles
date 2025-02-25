#!/bin/bash

music_info=$(curlie GET http://localhost:10767/api/v1/playback/now-playing | jq -r '"\(.info.name) - \(.info.artistName)"')

ICON=""

sketchybar --set $NAME label="$music_info" icon="$ICON"
