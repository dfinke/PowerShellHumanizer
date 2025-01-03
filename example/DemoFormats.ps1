function global:prompt { Write-host ""; return 'PowerShellHumanizer> ' }

function newline { Start-Sleep -Milliseconds 2000; Write-Host ''}
cls
Import-Module PowerShellHumanizer
Write-Host "`tPowerShell Humanizer Demo : Custom Formats`t" -ForegroundColor White -BackgroundColor DarkBlue
newline
<#
newline
Write-Host 'PowerShellHumanizer> [TimeSpan]::new(1,0,0)'
[TimeSpan]::new(1,0,0)
newline
Write-Host 'PowerShellHumanizer> ls'
ls
Start-Sleep -Milliseconds 900
newline#>