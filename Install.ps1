param([string]$InstallDirectory)

$fileList = @(
    'PowerShellHumanizer.psm1',
    'ConvertFrom-RomanNumeral.ps1',
    'ConvertTo-Casing.ps1',
    'ConvertTo-HumanDate.ps1',
    'ConvertTo-Ordinal.ps1',
    'ConvertTo-OrdinalWords.ps1',
    'ConvertTo-Plural.ps1',
    'ConvertTo-Quantity.ps1',
    'ConvertTo-RomanNumeral.ps1',
    'ConvertTo-Singular.ps1',
    'ConvertTo-Words.ps1',
    'RegisterExtensionMethods.ps1',
    'TryPowerShellHumanizer.ps1
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
$fileList | 
    ForEach-Object {
        $wc.DownloadFile("https://raw.github.com/dfinke/PowerShellHumanizer/master/$_","$installDirectory\$_")
    }
