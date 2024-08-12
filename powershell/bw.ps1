function Get-Password {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Name,
        [Boolean]$Hidden = $true
    )
    $result = (bw list items --search $Name | ConvertFrom-Json).login | Select-Object -Property username, password
    if ($result.Length -eq 0) {
        Write-Host -ForegroundColor Red "No password found"
        return
    }
    elseif ($result.Length -gt 1) {
        Write-Host -ForegroundColor Red "More than one password found, please specify"
        $counter = 0
        foreach ($username in $result.username) {
            Write-Host "["$counter "]" $username
            $counter++
        }
        $selector = Read-Host -MaskInput "Select the username"
        if ($result[$selector] -eq "") {
            Write-Host -ForegroundColor Red "Invalid selection"
            return
        }
        $result = $result[$selector]
    }
    if ($Hidden) {
        Write-Host -ForegroundColor Green "Password copied to clipboard"
        Set-Clipboard -Value $result.password
    } else {
        Write-Host $result
    }
    return $result
}