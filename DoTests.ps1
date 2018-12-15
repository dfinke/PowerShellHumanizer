param(
    [Switch]$UsePSCore
)

function Install-PSCore {
    param(
        $pscoreVerion = '6.2.0-preview.3',
        $os = 'win-x64'
    )

    $unZipPath = "$env:TEMP\pscore"

    if (!(Test-Path $unZipPath)) {
        $outfile = "$env:TEMP\pscore.zip"

        $url = "https://github.com/PowerShell/PowerShell/releases/download/v$($pscoreVerion)/PowerShell-$($pscoreVerion)-$($os).zip"

        "Downloading PS Core"
        Invoke-RestMethod $url -OutFile $outfile

        "Unzipping PS Core"
        Expand-Archive -Path $outfile -DestinationPath $unZipPath -Force

        Remove-Item $outfile -ErrorAction SilentlyContinue
    }

    "$unZipPath\pwsh.exe"
}

if ($UsePSCore) {
    $pwsh = Install-PSCore -os 'win-x64'
    & $pwsh
}

$PSVersionTable.PSVersion

if ($null -eq (Get-Module -ListAvailable pester)) {
    Install-Module -Name Pester -Repository PSGallery -Force -Scope CurrentUser
}

$result = Invoke-Pester -Script $PSScriptRoot\__tests__ -Verbose -PassThru

if ($result.FailedCount -gt 0) {
    throw "$($result.FailedCount) tests failed."
}