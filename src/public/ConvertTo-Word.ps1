<#
.SYNOPSIS
    Convert an Int to a String of one or more words.
.DESCRIPTION
    Convert an Int to a String of one or more words.
.PARAMETER Number
    One or more Ints to convert.
.EXAMPLE
    1337 | ConvertTo-Word
    one thousand three hundred and thirty-seven
#>
function ConvertTo-Word {
    [CmdletBinding()]
    [OutputType('string')]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [int[]]
        $Number
    )

    Process {
        foreach ($n in $Number) {
            [Humanizer.NumberToWordsExtension]::ToWords($n)
        }
    }
}