#! /usr/bin/pwsh

[CmdletBinding()]
param (
    [Parameter(Position = 0)]
    [ValidateSet('clean', 'build', 'test', 'publish', 'docs')]
    [string[]]
    $Task,

    [Parameter(Position = 1)]
    [int]
    $Major,

    [Parameter(Position = 2)]
    [int]
    $Minor,

    [Parameter(Position = 3)]
    [int]
    $Build,

    [Parameter(Position = 4)]
    [int]
    $Revision,

    [Parameter(Position = 5)]
    [string]
    $Prerelease
)

if ( (Get-Command 'nbgv' -CommandType Application -ErrorAction SilentlyContinue) ) {
    if (!$PSBoundParameters.ContainsKey('Major')) { $Major = $(nbgv get-version -v VersionMajor) }
    if (!$PSBoundParameters.ContainsKey('Minor')) { $Minor = $(nbgv get-version -v VersionMinor) }
    if (!$PSBoundParameters.ContainsKey('Build')) { $Build = $(nbgv get-version -v BuildNumber) }
    if (!$PSBoundParameters.ContainsKey('Revision')) { $Revision = $(nbgv get-version -v VersionRevision) }
}

$module = 'PowerShellHumanizer'
$parent = $PSScriptRoot
$parent = if ([string]::IsNullOrEmpty($parent)) { $pwd.Path } else { $parent }
$src = Join-Path $parent -ChildPath "src"
$docs = Join-Path $parent -ChildPath "docs"
$publish = [System.IO.Path]::Combine($parent, "publish", $module)
$csproj = [System.IO.Path]::Combine($src, "dotnet", "dependencies.csproj")
$bin = [System.IO.Path]::Combine($src, "dotnet", "bin")
$obj = [System.IO.Path]::Combine($src, "dotnet", "obj")
$lib = [System.IO.Path]::Combine($publish, "lib")
$ps51 = [System.IO.Path]::Combine($src, "ps51")

Write-Host "src: $src"
Write-Host "docs: $docs"
Write-Host "publish: $publish"
Write-Host "lib: $lib"
Write-Host "ps51: $ps51"
Write-Host "dotnet: $([Environment]::Version)"
Write-Host "ps: $($PSVersionTable.PSVersion)"

$manifest = @{
    Path                 = Join-Path -Path $publish -ChildPath "$module.psd1"
    Author               = 'Douglas Finke and Chris Hunt'
    CompanyName          = 'No Company'
    Copyright            = 'c 2024 All rights reserved.'
    CompatiblePSEditions = @("Desktop", "Core")
    Description          = 'PowerShell Humanizer wraps Humanizer: meets all your .NET needs for manipulating and displaying strings, enums, dates, times, timespans, numbers and quantities'
    GUID                 = '6dc9be51-eb93-4355-8648-0c725c0ac988'

    FunctionsToExport    = @()
    ModuleVersion        = [version]::new($Major, $Minor, $Build, $Revision)
    PowerShellVersion    = '5.1'
    ProjectUri           = "https://github.com/dfinke/PowerShellHumanizer"
    LicenseUri           = "https://github.com/dfinke/PowerShellHumanizer/blob/master/LICENSE.txt"
    RootModule           = "$module.psm1"
    Tags                 = @('PowerShell', 'Humanizer', 'strings', 'enums', 'dates', 'times', 'timespans', 'numbers', 'quantities')

    #RequiredModules      = @( )
    #CmdletsToExport      = ''
    #VariablesToExport    = ''
    AliasesToExport      = @('ConvertTo-DateWord','Kabab','Pluralize')

}

function Clean {
    param ()

    if (Test-Path $publish) {
        Remove-Item -Path $publish -Recurse -Force
    }
}

function Dependencies {
    param ()

    Foreach ($mod in $manifest.RequiredModules) {
        if ($null -eq (Get-Module -Name $mod.ModuleName -ListAvailable | Where-Object { [version]$_.Version -ge [version]$mod.ModuleVersion })) {
            Install-Module $mod.ModuleName -RequiredVersion $mod.ModuleVersion -Scope CurrentUser -Confirm:$false -Force
        }
    }
}

function Build {
    param ()

    New-Item -Path $publish -ItemType Directory -ErrorAction SilentlyContinue | Out-Null

    dotnet publish $csproj -o $lib
    Get-ChildItem -Path $lib -filter "*.json" | Remove-Item -Force -ErrorAction SilentlyContinue
    Get-ChildItem -Path $lib -filter "*.pdb" | Remove-Item -Force -ErrorAction SilentlyContinue
    Get-ChildItem -Path $lib -filter "System.Management.Automation.dll" | Remove-Item -Force -ErrorAction SilentlyContinue
    Get-ChildItem -Path $lib -filter "dependencies.dll" | Remove-Item -Force -ErrorAction SilentlyContinue
    
    # Copy PowerShell 5.1 dll's
    Copy-Item -Path "$ps51/*.dll" -Destination "$publish/lib"

    Copy-Item -Path "$src/$module.psm1" -Destination $publish
    Copy-Item -Path @("$parent/README.md") -Destination $publish -ErrorAction SilentlyContinue

    $publicFunctions = Get-ChildItem -Path "$src/public/*.ps1"
    $privateFunctions = Get-ChildItem -Path "$src/private/*.ps1" -ErrorAction SilentlyContinue
    $types = Get-ChildItem -Path "$src/types/*.ps1xml"
    $formats = Get-ChildItem -Path "$src/formats/*.ps1xml"

    New-Item -Path "$publish/types" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
    foreach ($type in $types) {
        Copy-Item -Path $type.FullName -Destination "$publish/types/$($type.Name)"
        'Update-TypeData -PrependPath "$PSSCriptRoot/types/{0}"' -f $type.Name | Add-Content "$publish/$module.psm1"
    }

    New-Item -Path "$publish/formats" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
    foreach ($format in $formats) {
        Copy-Item -Path $format.FullName -Destination "$publish/formats/$($format.Name)"
        #'Update-FormatData -PrependPath "$PSSCriptRoot/formats/{0}"' -f $format.Name | Add-Content "$publish/$module.psm1"
    }

    New-Item -Path "$publish/private" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
    foreach ($function in $privateFunctions) {
        Copy-Item -Path $function.FullName -Destination "$publish/private/$($function.Name)"
        '. "$PSSCriptRoot/private/{0}"' -f $function.Name | Add-Content "$publish/$module.psm1"
    }

    New-Item -Path "$publish/public" -ItemType Directory -ErrorAction SilentlyContinue | Out-Null
    foreach ($function in $publicFunctions) {
        Copy-Item -Path $function.FullName -Destination "$publish/public/$($function.Name)"
        '. "$PSSCriptRoot/public/{0}"' -f $function.Name | Add-Content "$publish/$module.psm1"
        $manifest.FunctionsToExport += $function.BaseName
    }

    Copy-Item -Path "$src/en-US" -Destination "$publish" -Recurse

    if ($PSBoundParameters.ContainsKey('Prerelease')) {
        $manifest.Add('Prerelease', $PreRelease)
    }

    New-ModuleManifest @manifest

}

function Test {
    param ()

    if ($null -eq (Get-Module Pester -ListAvailable | Where-Object { [version]$_.Version -ge [version]"5.5.0" })) {
        Install-Module -Name Pester -MinimumVersion 5.5.0 -Confirm:$false -Force
    }

    $config = New-PesterConfiguration -Hashtable @{
        Run        = @{
            Path = "tests"
            Exit = if ($true -eq $env:CI) { $ture } else { $false }
        }
        TestResult = @{
            Enabled      = $true
            OutputFormat = "NUnitXml"
        }
        Output     = @{ Verbosity = "Detailed" }
    }

    Invoke-Pester -Configuration $config

}


function Publish {
    param ()

    $repo = if ($env:PSPublishRepo) { $env:PSPublishRepo } else { 'PSGallery' }

    Publish-Module -Path $publish -Repository $repo -NuGetApiKey $env:PSPublishApiKey
}

function Docs {
    param ()

    if ($null -eq (Get-Module Build-Docs -ListAvailable | Where-Object { [version]$_.Version -ge [version]"0.2.0" })) {
        Install-Module -Name Build-Docs -MinimumVersion 0.2.0 -Confirm:$false -Force
    }

    Import-Module Build-Docs
    Import-Module $publish -Force

    $help = Get-HelpModuleData $module
    $aliases = Get-Alias | Where-Object Source -eq $module

    # docs/README.md
    $help | New-HelpDoc |
    Add-ModuleProperty Name -H1 |
    Add-ModuleProperty Description |
    Add-HelpDocText "Commands" -H2 |
    Add-ModuleCommand -AsLinks |
    Add-HelpDocText "Aliases" -H2 |
    Out-HelpDoc -Path 'docs/README.md'


    $aliases | ForEach-Object {
        '- `{0}` -> `{1}`' -f $_.Name, $_.Definition | Add-Content -Path 'docs/README.md'
    }

    # Individual Commands
    foreach ($command in $help.Commands) {
        $name = $command.Name
        $doc = New-HelpDoc -HelpModuleData $help
        $doc.Text = $command.ToMD()
        $doc | Out-HelpDoc -Path "docs/$name.md"
    }
}

switch ($Task) {
    { $_ -contains 'clean' } {
        Clean
    }
    { $_ -contains 'build' } {
        Clean
        Dependencies
        Build
    }
    { $_ -contains 'test' } {
        Dependencies
        Test
    }
    { $_ -contains 'publish' } {
        Dependencies
        Publish
    }
    { $_ -contains 'docs' } {
        Dependencies
        Docs
    }
    Default {
        Clean
        Build
    }
}