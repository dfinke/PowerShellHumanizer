function global:prompt { Write-host ""; return 'PowerShellHumanizer> ' }

function newline { Start-Sleep -Milliseconds 900; Write-Host ''}
cls
Import-Module PowerShellHumanizer
Write-Host "`tPowerShell Humanizer Demo : Integer Extension Methods `t" -ForegroundColor White -BackgroundColor DarkBlue
newline
newline
Write-Host 'PowerShellHumanizer> (3).Ordinalize()'
(3).Ordinalize()
newline
Write-Host 'PowerShellHumanizer> (3).ToWords()'
(3).ToWords()
newline
Write-Host 'PowerShellHumanizer> (Get-Date 2/13/2016) + (3).Weeks'
(Get-Date 2/13/2016) + (3).Weeks
newline
Start-Sleep -Milliseconds 900