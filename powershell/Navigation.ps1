# ${function:~}        = { Set-Location -Path ~ } cd is better
${function:...}      = { Set-Location -Path ..\.. }
${function:....}     = { Set-Location -Path ..\..\.. }
${function:.....}    = { Set-Location -Path ..\..\..\.. }
${function:......}   = { Set-Location -Path ..\..\..\..\.. }

# Absolute navigation
${function:docs}     = { Set-Location -Path ~/Documents }
${function:down}     = { Set-Location -Path ~/Downloads }
${function:dt}       = { Set-Location -Path ~/Desktop }
${function:mytmp}    = { Set-Location -Path ~/Temp }
${function:one}      = { Set-Location -Path ~/OneDrive }
${function:doku}     = { Set-Location -Path ~/doku && Get-ChildItem }

Invoke-Expression (& { (zoxide init powershell | Out-String) })