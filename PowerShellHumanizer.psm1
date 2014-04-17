$targetPath = $PSScriptRoot

$dll = dir $targetPath -Recurse humanizer.dll

if(!$dll) {
    
    if(!(Get-Command nuget -ErrorAction SilentlyContinue)) {
        Write-Host -ForegroundColor Red "Please install nuget http://www.nuget.org/"
        return
    }

    pushd
    cd $targetPath
    nuget install humanizer
    popd
}

$dll = dir $targetPath -Recurse humanizer.dll

Add-Type -Path $dll.FullName

. (Join-Path $PSScriptRoot ConvertFrom-RomanNumeral.ps1)
. (Join-Path $PSScriptRoot ConvertTo-Casing.ps1)
. (Join-Path $PSScriptRoot ConvertTo-HumanDate.ps1)
. (Join-Path $PSScriptRoot ConvertTo-Ordinal.ps1)
. (Join-Path $PSScriptRoot ConvertTo-OrdinalWords.ps1)
. (Join-Path $PSScriptRoot ConvertTo-Plural.ps1)
. (Join-Path $PSScriptRoot ConvertTo-Quantity.ps1)
. (Join-Path $PSScriptRoot ConvertTo-RomanNumeral.ps1)
. (Join-Path $PSScriptRoot ConvertTo-Singular.ps1)
. (Join-Path $PSScriptRoot ConvertTo-Words.ps1)
. (Join-Path $PSScriptRoot RegisterExtensionMethods.ps1)

    Register-HumanizerString
    Register-HumanizerInteger
    Register-HumanizerTimeSpan
    Register-HumanizerDateTime
