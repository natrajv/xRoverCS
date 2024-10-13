$sFiles=Get-ChildItem -File -filter *.txt
Clear-Host
foreach ($sFile in $sFiles) {
    [string] $sFile1 = $sFile
    $sFile1 = $sFile1.ToUpper()
    Rename-Item $sFile $sFile1 -WhatIf
}