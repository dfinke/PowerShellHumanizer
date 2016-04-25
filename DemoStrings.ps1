function global:prompt { Write-host ""; return 'PowerShellHumanizer> ' }

function newline { Start-Sleep -Milliseconds 900; Write-Host ''}
cls
Import-Module PowerShellHumanizer
Write-Host "`tPowerShell Humanizer Demo : String Extension Methods `t" -ForegroundColor White -BackgroundColor DarkBlue
newline
newline
Write-Host 'PowerShellHumanizer> ''then add nodes under it.''.Transform("UpperCase") '
'then add nodes under it.'.Transform("UpperCase") 
newline
Write-Host 'PowerShellHumanizer> ''then add nodes under it.''.ToTitleCase()'
'then add nodes under it.'.ToTitleCase()
newline
Write-Host 'PowerShellHumanizer> ''FromTitleCase''.Underscore()'
'FromTitleCase'.Underscore()
newline
Write-Host 'PowerShellHumanizer> ''then add nodes under it.''.Truncate(3,"Words")'
'then add nodes under it.'.Truncate(3,"Words")
newline
Write-Host '''then add nodes under it.''.Truncate(3,"Characters")'
'then add nodes under it.'.Truncate(3,"Characters")
newline
Write-Host 'PowerShellHumanizer> ''then add nodes under it.''.Truncate(7, "Characters", ''-'')' 
'then add nodes under it.'.Truncate(7, "Characters", '-') 
newline
Write-Host 'PowerShellHumanizer> ''then add nodes under it.''.Dehumanize() '
'then add nodes under it.'.Dehumanize() 
newline
Write-Host 'PowerShellHumanizer> ''string''.ToQuantity(50)'
'string'.ToQuantity(50)
newline
Write-Host 'PowerShellHumanizer> ''string''.ToQuantity(50, "Words")'
'string'.ToQuantity(50, "Words")
newline
Write-Host 'PowerShellHumanizer> (Get-Date).Year.ToRoman()'
(Get-Date).Year.ToRoman()
newline