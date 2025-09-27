#!/bin/bash

TOTAL_MEM=$(sysctl -n hw.memsize)
TOTAL_MEM=$((TOTAL_MEM / 1024 / 1024)) # 转换为 MB

USED_MEM_RAW=$(top -l 1 | awk '/PhysMem/ {print $2}')

if [[ $USED_MEM_RAW == *G ]]; then
    USED_MEM=$(echo "$USED_MEM_RAW" | sed 's/G//' | awk '{print $1 * 1024}') # 转 MB
else
    USED_MEM=$(echo "$USED_MEM_RAW" | sed 's/M//') # 直接取 MB
fi

MEM_PERCENT=$(echo "scale=1; $USED_MEM / $TOTAL_MEM * 100" | bc)

sketchybar --set $NAME label=" $MEM_PERCENT%"
