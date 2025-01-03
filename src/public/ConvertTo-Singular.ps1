<#
.SYNOPSIS
    Convert the string to the singular form.
.DESCRIPTION
    Convert the string to the singular form.
.PARAMETER Word
    One or more Strings to convert.
.EXAMPLE
    "cats" | ConvertTo-Singular
    cat
#>
function ConvertTo-Singular {
    [CmdletBinding()]
    [OutputType('string')]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [Alias('String', 'Target')]
        [string[]]
        $Word
    )

    Process {
        foreach ($w in $Word) {
            [Humanizer.InflectorExtensions]::Singularize($w)
        }
    }
}