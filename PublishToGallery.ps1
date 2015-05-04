$p = @{
    Name = "PowerShellHumanizer"
    NuGetApiKey = $NuGetApiKey 
    LicenseUri = "https://github.com/dfinke/PowerShellHumanizer/blob/master/LICENSE" 
    Tag = "PowerShell","Humanizer"
    ReleaseNote = "Ships the DLL"
    ProjectUri = "https://github.com/dfinke/PowerShellHumanizer"
}

Publish-Module @p