# aka PSReadLine

# read key: [System.Console]::ReadKey()
# get current bindings: Get-PSReadLineKeyHandler

# PSReadLineOptions
Set-PSReadLineOption -EditMode            Vi               # Vi Keybindings
Set-PSReadLineOption -PredictionViewStyle InlineView
Set-PSReadLineOption -PredictionSource    HistoryAndPlugin
# Set-PSReadLineOption -ContinuationPrompt  "`e[36m CR > " # Use Starship instead
# PSReadLineKeyHandlers
Set-PSReadLineKeyHandler -Chord "Control+Oem4" -Function ViCommandMode -ViMode Insert # ^[ to Escape
Set-PSReadLineKeyHandler -Chord "Ctrl+a"	   -Function BeginningOfLine
Set-PSReadLineKeyHandler -Chord "Ctrl+e"	   -Function EndOfLine
Set-PSReadLineKeyHandler -Chord "Ctrl+p"	   -Function PreviousHistory
Set-PSReadLineKeyHandler -Chord "Ctrl+f"       -Function AcceptNextSuggestionWord
Set-PSReadLineKeyHandler -Chord "Alt+f"        -Function AcceptSuggestion
Set-PSReadLineKeyHandler -Chord "Ctrl+n"	   -Function NextHistory
Set-PSReadLineKeyHandler -Chord "Ctrl+w"       -Function BackwardKillWord
Set-PSReadLineKeyHandler -Chord "Ctrl+Backspace" -Function BackwardKillWord
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+Backspace" -Function BackwardKillLine
Set-PSReadLineKeyHandler -Chord "Alt+Backspace" -Function BackwardKillLine
Set-PSReadLineKeyHandler -Chord "Ctrl+Delete" -Function KillWord
Set-PSReadLineKeyHandler -Chord "Ctrl+Shift+Delete" -Function KillLine
Set-PSReadLineKeyHandler -Chord "Alt+Delete" -Function KillLine
Set-PSReadLineKeyHandler -Chord "Ctrl+c"     -Function CopyOrCancelLine  -ViMode Insert
Set-PSReadLineKeyHandler -Chord "Ctrl+c"     -Function CopyOrCancelLine  -ViMode Command
## Use <Tab> to Invoke MenuComplete
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

. $(Join-Path $DOTFILES "tools" "powershell" "Keymap" "Colemak.ps1")