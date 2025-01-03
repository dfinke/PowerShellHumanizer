<#
.SYNOPSIS
    Convert an Int to a Roman Numeral String.
.DESCRIPTION
    Convert an Int to a Roman Numeral String.
.PARAMETER Number
    One or more Ints to convert.
.EXAMPLE
    ConvertTo-RomanNumeral 12
    XII
#>
function ConvertTo-RomanNumeral {
    [CmdletBinding()]
    [OutputType('string')]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [int[]]$Number
    )

    Process {
        foreach ($n in $Number) {
            [Humanizer.RomanNumeralExtensions]::ToRoman($n)
        }
    }
}