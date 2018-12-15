Import-Module $PSScriptRoot\..\PowerShellHumanizer.psd1 -Force

Describe "Test Humanizer" {
    It "Flight test should be true" {
        $true | Should Be $false
    }
}