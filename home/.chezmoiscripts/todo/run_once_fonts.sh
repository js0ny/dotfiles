#!/bin/bash

curl -L https://github.com/lxgw/LxgwWenKai/releases/download/v1.520/lxgw-wenkai-v1.520.zip -o /tmp/lxgw-wenkai.zip
unzip /tmp/lxgw-wenkai.zip -d ~/.local/share/fonts/

curl -L https://github.com/lxgw/LxgwNeoXiHei/releases/download/v1.223/LXGWNeoXiHeiPlus.ttf -o /tmp/lxgw-xihei.zip
unzip /tmp/lxgw-xihei.zip -d ~/.local/share/fonts/

curl -L https://github.com/subframe7536/maple-font/releases/download/v7.7/MapleMono-NF-CN-unhinted.zip -o /tmp/maple-mono.zip
unzip /tmp/maple-mono.zip -d ~/.local/share/fonts/

fc-cache -fv
