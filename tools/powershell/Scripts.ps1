function CsvToMarkdown {
    param( [string]$csv)
    $counter = 0
    $column = $csv.Split("`n")[0].Split(",").Length
    $aHeader = " --- |"
    $header = "|" + $aHeader * $column
    $csv.replace(",", " | ").Split("`n") | ForEach-Object {
        if ($counter -eq 0) {
            Write-Output "| $_ |"
            $counter++
            Write-Output $header
        }
        else {
            Write-Output "| $_ |"
        }
    }
}