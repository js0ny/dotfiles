# aka PSReadLine
# PSReadLineOptions
Set-PSReadLineOption -EditMode            Vi               # Vi Keybindings
Set-PSReadLineOption -PredictionViewStyle ListView
Set-PSReadLineOption -PredictionSource    HistoryAndPlugin
# Set-PSReadLineOption -ContinuationPrompt  "`e[36m CR > " # Use Starship instead
# PSReadLineKeyHandlers
## Colemak hnei
Set-PSReadLineKeyHandler -Chord "n" -Function NextHistory -ViMode Command
Set-PSReadLineKeyHandler -Chord "e" -Function PreviousHistory -ViMode Command
Set-PSReadLineKeyHandler -Chord "i" -Function ViForwardChar -ViMode Command
## Similar position to [i] in QWERTY
Set-PSReadLineKeyHandler -Chord "l" -Function ViInsertMode -ViMode Command
Set-PSReadlineKeyHandler -Chord "L" -Function ViInsertAtBegining -ViMode Command
## Ne{[k]s}t
Set-PSReadLineKeyHandler -Chord "k" -Function RepeatSearch -ViMode Command
Set-PSReadLineKeyHandler -Chord "K" -Function RepeatSearchBackward -ViMode Command
## [j]ump
Set-PSReadLineKeyHandler -Chord "j" -Function NextWordEnd -ViMode Command
Set-PSReadLineKeyHandler -Chord "J" -Function ViEndOfGlob -ViMode Command
## Use N to Join
Set-PSReadLineKeyHandler -Chord "N" -Function ViJoinLines -ViMode Command
Set-PSReadLineKeyHandler -Chord "Control+Oem4" -Function ViCommandMode -ViMode Insert # ^[ to Escape
Set-PSReadLineKeyHandler -Chord "Ctrl+a"	   -Function BeginningOfLine
Set-PSReadLineKeyHandler -Chord "Ctrl+e"	   -Function EndOfLine
Set-PSReadLineKeyHandler -Chord "Ctrl+p"	   -Function PreviousHistory
Set-PSReadLineKeyHandler -Chord "Ctrl+p"	   -Function PreviousHistory
Set-PSReadLineKeyHandler -Chord "Ctrl+n"	   -Function NextHistory

## Use <Tab> to Invoke MenuComplete
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
