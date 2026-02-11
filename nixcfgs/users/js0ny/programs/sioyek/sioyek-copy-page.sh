#!/usr/bin/env bash

RAW_PAGE="$1"
RAW_PATH="$2"
FILE_PATH="$RAW_PATH"

# FILE_PATH="${RAW_PATH#\"}"  # 去除开头的 "
# FILE_PATH="${FILE_PATH%\"}" # 去除结尾的 "
# FILE_PATH="${FILE_PATH#\'}" # 去除开头的 '
# FILE_PATH="${FILE_PATH%\'}" # 去除结尾的 '

PAGE_NUM="$RAW_PAGE"
DISPLAY_PAGE=$((PAGE_NUM + 1))
DPI=300

notify() {
    local msg="$1"
    local level="${2:-normal}" # normal / critical

    if [[ "$(uname)" == "Darwin" ]]; then
        osascript -e "display notification \"$msg\" with title \"Sioyek\""
    elif command -v notify-send >/dev/null 2>&1; then
        notify-send -u "$level" -a "Sioyek" "Page Copy" "$msg"
    fi
}

if ! command -v pdftocairo >/dev/null 2>&1; then
    notify "缺少依赖: pdftocairo (请安装 poppler_utils)" "critical"
    exit 1
fi

if [[ ! -f "$FILE_PATH" ]]; then
    notify "文件不存在: $FILE_PATH" "critical"
    exit 1
fi

OS_TYPE=$(uname)

if [[ "$OS_TYPE" == "Darwin" ]]; then
    TMP_IMG=$(mktemp /tmp/sioyek_page.XXXXXX.png)

    # 渲染到临时文件
    pdftocairo -png -f "$PAGE_NUM" -l "$PAGE_NUM" -r "$DPI" -singlefile "$FILE_PATH" "${TMP_IMG%.png}"

    if [[ -f "$TMP_IMG" ]]; then
        # 写入剪贴板
        osascript -e "set the clipboard to (read (POSIX file \"$TMP_IMG\") as JPEG picture)"
        rm "$TMP_IMG"
        notify "已复制第 $DISPLAY_PAGE 页"
    else
        notify "渲染失败" "critical"
        exit 1
    fi

elif [[ "$OS_TYPE" == "Linux" ]]; then
    if ! command -v wl-copy >/dev/null 2>&1; then
        notify "缺少依赖: wl-copy (请安装 wl-clipboard)" "critical"
        exit 1
    fi

    # 使用管道直接传输，set -o pipefail 确保渲染失败时报错
    set -o pipefail
    if pdftocairo -png -f "$PAGE_NUM" -l "$PAGE_NUM" -r "$DPI" -singlefile "$FILE_PATH" - | wl-copy --type image/png; then
        sleep 0.1
        notify "已复制第 $DISPLAY_PAGE 页"
    else
        notify "复制失败 (pdftocairo 或 wl-copy 出错)" "critical"
        exit 1
    fi
fi

