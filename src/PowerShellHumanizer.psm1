# Load  dlls
if ($PSVersionTable.PSVersion -lt [version]"7.4.6") {
    Add-Type -Path "$PSScriptRoot/lib/Humanizer.dll"
}

if ($PSCulture -ne 'en-US') {
    if (Test-Path "$PSScriptRoot/lib/$PSCulture") {
        Add-Type -Path "$PSScriptRoot/lib/$PSCulture/Humanizer.resources.dll"
    } else {
        Write-Warning "Humanizer doesn't currently support '$PSCulture'."
    }
}

if (Get-Module -Name Terminal-Icons -ListAvailable -ErrorAction SilentlyContinue) {
    Update-FormatData -PrependPath "$PSSCriptRoot/formats/FileInfoIcons.format.ps1xml"
} else {
    Update-FormatData -PrependPath "$PSSCriptRoot/formats/FileInfo.format.ps1xml"
}

Update-FormatData -PrependPath "$PSSCriptRoot/formats/TimeSpan.format.ps1xml"

