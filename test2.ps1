<#** Purpose: Renaaming file
*--
* Concepts: WhatIf, Renaming file, Foreach, RegEx, Padding, Test path
*--
Ver.: v1.0.0 
Author: V Natarajan [chp.chennai@gmail.com]
ICR: 13 Oct 2024_0458
LUD: 13 Oct 2024_1644
*=====
#>

#>>Settings
[string]$sPathSrc = "" #"C:\Temp\"
[string]$sPathDst = "Temp1\"
[string]$sFileType = "*.txt" #Filter for required files (PDF, DOCX etc.)
#--
[bool]$bRename = $false #false for copy to new path
#--
[boolean]$bReplaceAllText = $true #false to retain existing name
[string]$sReplaceFileName = "newname"
[string]$sTimeStamp = '-20241013_0540' #Timestamp


#>>Init
[int32]$nSl = 0 #File serial
#--
$sFile = ""
$sFile1 = ""

#>>Renaming file with WhatIf
#--Get file names
$sFiles = Get-ChildItem -path $sPathSrc -File -filter $sFileType 

Clear-Host
#--Whatif rename files 
foreach ($sFile in $sFiles) {
  if ($bReplaceAllText) {
    $sFile1 = $sReplaceFileName + $sFile.Extension
  } else {
    $sFile1 = $sFile
  }
  
  #--File name: All lower
  $sFile1 = $sFile1.ToLower()
  
  #--File name: Replace all spaces with single hyphen
  $sFile1 = $sFile1 -replace ' ', '-'
  $sFile1 = $sFile1 -replace '(-){2,}', '-'
  
  #--File name: Prefix serial
  $nSl = $nSl + 1
  $sFile1 = $($nSl.ToString().PadLeft(3, '0')) + "-" + $sFile1
  
  #--File name: Suffix timestamp[1]
  $sFile1 = $sFile1 -Replace '\.txt$', $($sTimeStamp + '.txt')

  #--Copy/ Overwrite file
  if ($bRename) {
    Rename-Item  $($sPathSrc + $sFile.Name) $sFile1  #-WhatIf 
  } else {
    #--Check Path
    if (!(Test-Path -path $sPathDst)) {
      New-Item -ItemType Directory -Name $sPathDst
    }
    Copy-Item $sFile.Name -Destination $($sPathDst + $sFile1) -Force
  }
}

<#Output: TRUE
What if: Performing the operation "Rename File" on target "Item: C:\Temp\Test TEST.txt Destination: C:\Temp\TEST TEST.TXT".
What if: Performing the operation "Rename File" on target "Item: C:\Temp\test.txt Destination: C:\Temp\TEST.TXT".
#>

<#*==Test Data==*
Test TEST.txt
test.txt
#>
  
<#*==References==*
[1] "Online Replace Tool," Rextester. [Online]. Available: https://rextester.com/replace. Accessed: Oct. 11, 2024.
#>