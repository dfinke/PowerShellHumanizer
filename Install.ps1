param([string]$InstallDirectory)

$fileList = @(
    'PowerShellHumanizer.psm1',
    'PowerShellHumanizer.psd1',
    'TryPowerShellHumanizer.ps1'
)


if ('' -eq $InstallDirectory)
{
    $personalModules = Join-Path -Path ([Environment]::GetFolderPath('MyDocuments')) -ChildPath WindowsPowerShell\Modules
    if (($env:PSModulePath -split ';') -notcontains $personalModules)
    {
        Write-Warning "$personalModules is not in `$env:PSModulePath"
    }

    if (!(Test-Path $personalModules))
    {
        Write-Error "$personalModules does not exist"
    }

    $InstallDirectory = Join-Path -Path $personalModules -ChildPath PowerShellHumanizer
}

if (!(Test-Path $InstallDirectory))
{
    $null = mkdir $InstallDirectory    
}

$wc = New-Object System.Net.WebClient
#$wc.Encoding = [System.Text.Encoding]::ASCII
$fileList | 
    ForEach-Object {
        $wc.DownloadFile("https://raw.github.com/dfinke/PowerShellHumanizer/master/$_","$installDirectory\$_")
    }
