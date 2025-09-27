#!/usr/bin/env bash
# vim:ft=bash

export LC_TIME=zh_CN.UTF-8

# 获取当前日期，并格式化为“3月3日 星期一”格式
DATE=$(date "+%-m月%-d日 %A")

# 发送到 SketchyBar
sketchybar --set $NAME label="$DATE"
