<#
.SYNOPSIS
    Convert a string to a Hyphenated string.
.DESCRIPTION
    Convert a string to a Hyphenated string.
.PARAMETER String
    A string to convert.
.NOTES
    This requires the input string to have some word sepration. Either whitespace or Title case.
.EXAMPLE
    ConvertTo-HyphenatedString "verb noun"
    verb-noun
.EXAMPLE
    ConvertTo-HyphenatedString PowerShellHumanizer
    power-shell-humanizer
#>
function ConvertTo-HyphenatedString {
    [CmdletBinding()]
    [Alias('Kabab')]
    [OutputType('string')]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [string]
        $String
    )

    Process {
        [Humanizer.InflectorExtensions]::Dasherize($String.Underscore())
    }
}