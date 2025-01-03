<#
.SYNOPSIS
    Convert an int to an ordinal number.
.DESCRIPTION
    Convert an int to an ordinal number with the correct suffix.
.PARAMETER Target
    An int to convert.
.EXAMPLE
    ConvertTo-Ordinal 1
    1st
#>
function ConvertTo-Ordinal {
    [CmdletBinding()]
    [OutputType('string')]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [int]$Target
    )

    Process {
        [Humanizer.OrdinalizeExtensions]::Ordinalize($Target)
    }
}
