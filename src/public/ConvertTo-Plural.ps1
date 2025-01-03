<#
.SYNOPSIS
    Convert the string to the pural form.
.DESCRIPTION
    Convert the string to the pural form.
.PARAMETER Word
    A string to convert.
.EXAMPLE
    "dog" | ConvertTo-Plural
    dogs
#>
function ConvertTo-Plural {
    [CmdletBinding()]
    [Alias('Pluralize')]
    [OutputType('string')]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [Alias('String', 'Target')]
        $Word
    )

    Process {
        [Humanizer.InflectorExtensions]::Pluralize($word)
    }
}