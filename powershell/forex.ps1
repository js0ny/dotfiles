$_userForexToday = (Get-Content ~/.forex | ConvertFrom-Json).conversion_rates

function Update-ForexData {
    ((Invoke-WebRequest "$_userForexUrl").Content | ConvertFrom-Json).conversion_rates > ~/.forex
}
function Get-ExchangeRate {
    param (
        [string] $From,
        [string] $To = "CNY",
        [double] $Value = 1
    )
    if (-not $from) {
        Get-ForexOverview
        return
    }
    Write-Host $From : $To "  "  -NoNewline -ForegroundColor DarkGreen
    ($Value * ($_userForexToday.$To / $_userForexToday.$From)) | Write-Host -ForegroundColor DarkBlue
}

function Get-ForexOverview {
    Get-ExchangeRate -From GBP -To CNY -Value 1
    Get-ExchangeRate -From USD -To CNY -Value 1
    Get-ExchangeRate -From HKD -To CNY -Value 1
    Get-ExchangeRate -From EUR -To CNY -Value 1
    Get-ExchangeRate -From CNY -To JPY -Value 1
}

Set-Alias "forex" "Get-ExchangeRate"