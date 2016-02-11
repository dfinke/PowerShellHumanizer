$ModuleName   = "PowerShellHumanizer"
$ModulePath   = "C:\Program Files\WindowsPowerShell\Modules"
$TargetPath = "$($ModulePath)\$($ModuleName)"

if(!(Test-Path $TargetPath)) { md $TargetPath | out-null}

$FilesToCopy = dir *.psm1, *.psd1, *.dll, *.ps1xml

$FilesToCopy | ForEach {
    Copy-Item -Verbose -Path $_.FullName -Destination "$($TargetPath)\$($_.name)"
}