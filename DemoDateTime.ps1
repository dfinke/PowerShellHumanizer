function global:prompt { Write-host ""; return 'PowerShellHumanizer> ' }

function newline { Start-Sleep -Milliseconds 900; Write-Host ''}
cls
Import-Module PowerShellHumanizer
Write-Host "`tPowerShell Humanizer Demo : Date Time Extension Methods `t" -ForegroundColor White -BackgroundColor DarkBlue
newline
newline
Write-Host 'PowerShellHumanizer> $past = (Get-Date 2/13/2016).AddMinutes(-1).AddSeconds(-20)'
Write-Host 'PowerShellHumanizer> $time = (Get-Date 2/13/2016) - $past'
$past = (Get-Date 2/13/2016).AddMinutes(-1).AddSeconds(-20)
$time = (Get-Date 2/13/2016) - $past
newline
Write-Host 'PowerShellHumanizer> $time.Humanize()'
$time.Humanize()
newline
Write-Host 'PowerShellHumanizer> $time.Humanize(2)'
$time.Humanize(2)
newline
Write-Host 'PowerShellHumanizer> (Get-Date).Humanize()'
(Get-Date).Humanize()
newline
Write-Host 'PowerShellHumanizer> (Get-Date).Humanize($true) #UTC'
(Get-Date).Humanize($true)
Start-Sleep -Milliseconds 900
newline