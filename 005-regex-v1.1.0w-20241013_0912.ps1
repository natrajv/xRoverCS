<#** Purpose: RegEx
*--
* Concepts: RegEx
*--
Ver.: v1.1.0w
ICR: 12 Oct 2024_1742
LUD: 13 Oct 2024_0912
*=====
 #>
<#*==Index==*
>> Match for given string
>> Check for 3-digit number
>> Check for 3-digit number at the end
>> Simple Find and Replace
>> Find and Replace with Switch RegEx
>> Remove double characters[2]
>> Find complete word using 'Select-String'

 #>

 #>> Match for given string
 'This is for testing' -Match 'for'
 #Output: TRUE

 #>> Check for 3-digit number 
 'Hello Nats  Jittu 234.' -match '\d{3}'
 #Output: TRUE
 
 #>> Check for 3-digit number at the end
 'Hello Nats  Jittu 234' -match '\d{3}$'
 #Output: TRUE
 
 #>> Simple Find and Replace

$sTmp="XYZ is to be replaced with ABC" -replace 'XYZ','ABC'
Write-Output $sTmp

#>> Find and Replace with Switch RegEx
$sTmp="Nats, 1234, Jittu, Divi, 3456, ABC"
Clear-Host
switch -RegEx ($sTmp1) {
    'Nats' { $sTmp = $sTmp -replace 'Nats', 'NatsX' }
    345 { $sTmp = $sTmp -replace '\d{3}', 999 }
    Default {}
} 
Write-Output $sTmp

#>> Remove double characters[2]
$sTmp = @("File  Name and    long.txt", 'test   testx.txt')

foreach ($sTmp1 in $sTmp) {
    $sTmp1 = $sTmp1 -replace ' ', '-'
    $sTmp1 = $sTmp1 -replace '(-){2,}', '-'
    Write-Output $sTmp1
}

#>> Find complete word using 'Select-String'
#Find word with 02-03 characters, full word
"Hello helloX   he hEllo" | select-string "\b\w{2,3}\b" -allmatches
#Output: he

<# *==Notes==*
*--Basic RegEx[3]
\d digit [0-9]
\w alpha numeric [a-zA-Z0-9_]
\s whitespace character
.  any character except newline
() sub-expression
\  escape the next character

*--Quantifier[4]
\w Match any word character (Matches character)
\w+ Match 1 or more preceding token (Matches word)
\w{3} Match 3 of the preceding token (Match & select first 3 characters)
\w{3,} Match 3 or more of the preceding token (Match 3 char & select word)

*--Practice RegEx[4]
https://regexr.com/

*--

#>

<#*==References==*
[1] "How to Use Regular Expressions in PowerShell," PDQ Blog. [Online]. Available: https://www.pdq.com/blog/how-to-use-regular-expression-in-powershell/. Accessed: Oct. 11, 2024.
[2] "How to remove double characters," Super User. [Online]. Available: https://superuser.com/questions/1559650/how-to-remove-double-characters. Accessed: Oct. 11, 2024.
[3] "PowerShell Regex (Regular Expression)," PowerShell Explained, Jul. 31, 2017. [Online]. Available: https://powershellexplained.com/2017-07-31-Powershell-regex-regular-expression/. Accessed: Oct. 11, 2024.
[4] "Regexr - Learn, Build, & Test Regular Expressions," Regexr. [Online]. Available: https://regexr.com/. Accessed: Oct. 11, 2024.

#>