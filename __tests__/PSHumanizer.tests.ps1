Import-Module $PSScriptRoot\..\PowerShellHumanizer.psd1 -Force

Describe "Test Humanizer" {
    It "Flight test" {
        $true | Should Be $true
    }
}