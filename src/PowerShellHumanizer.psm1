# Load  dlls
if ($PSVersionTable.PSVersion.Major -lt 6) {
    Add-Type -Path "$PSScriptRoot/lib/System.Buffers.4.0.2.0.dll"
    Add-Type -Path "$PSScriptRoot/lib/System.Runtime.CompilerServices.Unsafe.4.0.4.1.dll"
}
Add-Type -Path "$PSScriptRoot/lib/Humanizer.dll"

if (Get-Module -Name Terminal-Icons -ListAvailable -ErrorAction SilentlyContinue) {
    Update-FormatData -PrependPath "$PSSCriptRoot/formats/FileInfoIcons.format.ps1xml"
} else {
    Update-FormatData -PrependPath "$PSSCriptRoot/formats/FileInfo.format.ps1xml"
}

Update-FormatData -PrependPath "$PSSCriptRoot/formats/TimeSpan.format.ps1xml"

