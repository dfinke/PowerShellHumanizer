<#
.SYNOPSIS
    Convert an int to an ordinal word.
.DESCRIPTION
    Convert an int to an ordinal word. First, Second, etc.
.PARAMETER Target
    An int to convert.
.EXAMPLE
    ConvertTo-OrdinalWord 2
    second
#>
function ConvertTo-OrdinalWord {
    [CmdletBinding()]
    [OutputType('string')]
    param(
        [Parameter(ValueFromPipeline = $true)]
        [int]$Target
    )

    Process {
        [Humanizer.NumberToWordsExtension]::ToOrdinalWords($Target)
    }
}