<#
.SYNOPSIS
    Format the given string with the given case.
.DESCRIPTION
    Format the given string with the given case. Options are Title, AllCaps, LowerCase, and Sentence.
.PARAMETER Target
    One or more strings to format.
.PARAMETER Case
    The target casing. Options are Title, AllCaps, LowerCase, and Sentence. Default is Title.
.EXAMPLE
    "the powershell gallery" | ConvertTo-Casing -Case Title
    the Powershell Gallery
#>
function ConvertTo-Casing {
    [CmdletBinding()]
    [OutputType('string')]
    param(
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [string[]]$Target,

        [Parameter()]
        [Humanizer.LetterCasing]
        $Case = "Title"
    )

    Process {
        foreach ($t in $Target) {
            [Humanizer.CasingExtensions]::ApplyCase($t, $Case)
        }
    }
}