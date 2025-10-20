if (Get-Command "kmonad" -ErrorAction SilentlyContinue) {
    $KMonadPath = (Get-Command "kmonad").Source
}
else {
    $KMonadPath = "D:\bin\kmonad.exe"
}

$KMonadConfig = "$Env:DOTFILES\tools\kmonad\windows.kbd"

Start-Process -FilePath $KMonadPath -ArgumentList $KMonadConfig -WindowStyle Hidden
