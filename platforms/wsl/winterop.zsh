# $DOTFILES/platforms/wsl/winterop.zsh
# Sourced by $DOTFILES/platforms/wsl/zshrc 在 $DOTFILES/platforms/wsl/zshrc 中被引用

# Defines the interop commands between WSL and Windows

export FILE_EXPLORER="explorer.exe" # Directory Opus

alias psw="tasklist.exe"
alias killw="taskkill.exe"
alias shutdownw="shutdown.exe /s /t 0"
alias rebootw="shutdown.exe /r /t 0"
alias ipconfig="ipconfig.exe"
alias netstatw="netstat.exe"
alias diskpart="diskpart.exe"
alias winget="winget.exe"
alias pastew='pwsh.exe -NoProfile -Command "Get-Clipboard"'
alias ollama="ollama.exe"
#  https://github.com/stuartleeks/wsl-notify-send
alias notify-send="wsl-notify-send.exe"

# WSL open
open() {
  local target=$1

  if command -v "$FILE_EXPLORER" >/dev/null 2>&1; then
    "$FILE_EXPLORER" "$target"
  else
    command open "$target"
  fi
}
