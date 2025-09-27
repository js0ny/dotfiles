#!/usr/bin/env pwsh

Install-Package PSFzf -Force
Install-Package CompletionPredictor -Force

git clone --depth 1 https://github.com/catppuccin/powershell.git (Join-Path $Env:PSModulePath.Split(':')[0] Catppuccin)
