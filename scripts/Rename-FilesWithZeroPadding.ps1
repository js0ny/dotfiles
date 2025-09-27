<#
.SYNOPSIS
Rename files with a specified extension in a folder, padding the numeric part with zeros.
.PARAMETER ext
The extension of the files to rename, without the dot. Default is "md".
.PARAMETER Numeral
If specified, the files will be renamed in the order of their numeric part.
.EXAMPLE
Rename-FilesWithZeroPadding.ps1 -ext "txt"
Renames all files with the extension "txt" in the current folder, padding the numeric part with zeros.
For example: '1.txt', '2.txt', ... '12.txt' -> '01.txt', '02.txt', ... '12.txt'.
.EXAMPLE
Rename-FilesWithZeroPadding.ps1 -Numeral # This set the Numeral switch to false
Renames all files with the default extension "md" in the current folder, in the order of their filenames.
For example: 'file1.md', 'file2.md', ... 'file12.md' -> '01.md', '02.md', ... '12.md'.
#>
param(
    [string]$ext = "md",
    [switch]$Numeral
)
if ($Numeral) {
    $files = $files | Sort-Object { [int]($_.BaseName -replace '\D', '') }
}
else {
    $files = Get-ChildItem -Filter "*.$ext" | Sort-Object Name
    $fnamecnt = 1
}
$cnt = $files.Count

$paddingLength = $cnt.ToString().Length

foreach ($file in $files) {
    if ($Numeral) {
        $number = [int]($file.BaseName -replace '\D', '')
        $newNumber = $number.ToString().PadLeft($paddingLength, '0')
        $newName = "$newNumber.$ext"
    }
    else {
        $newName = ($fnamecnt++).ToString().PadLeft($paddingLength, '0') + ".$ext"
    }

    Rename-Item -Path $file.FullName -NewName $newName
}
