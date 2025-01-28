$PSHistPath = (Get-PSReadlineOption).HistorySavePath

if (Test-Path $PSHistPath) {
    $PSHist = Get-Content $PSHistPath
    $PSHist | Group-Object | Sort-Object Count -Descending | Select-Object -First 10 Count, Name
}
else {
    Write-Host "No history file found."
}
