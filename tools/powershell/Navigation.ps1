# ${function:~}        = { Set-Location -Path ~ } cd is better
${function:...}      = { Set-Location -Path (Join-Path -Path (Join-Path -Path .. -ChildPath ..) -ChildPath ..) }
${function:....}     = { Set-Location -Path (Join-Path -Path (Join-Path -Path (Join-Path -Path .. -ChildPath ..) -ChildPath ..) -ChildPath ..) }
${function:.....}    = { Set-Location -Path (Join-Path -Path (Join-Path -Path (Join-Path -Path (Join-Path -Path .. -ChildPath ..) -ChildPath ..) -ChildPath ..) -ChildPath ..) }
${function:......}   = { Set-Location -Path (Join-Path -Path (Join-Path -Path (Join-Path -Path (Join-Path -Path (Join-Path -Path .. -ChildPath ..) -ChildPath ..) -ChildPath ..) -ChildPath ..) -ChildPath ..) }

# Absolute navigation
${function:docs}     = { Set-Location -Path (Join-Path -Path $HOME -ChildPath "Documents") }
${function:down}     = { Set-Location -Path (Join-Path -Path $HOME -ChildPath "Downloads") }
${function:dt}       = { Set-Location -Path (Join-Path -Path $HOME -ChildPath "Desktop") }
${function:one}      = { Set-Location -Path (Join-Path -Path $HOME -ChildPath "OneDrive") }


Invoke-Expression (& { (zoxide init powershell | Out-String) })
