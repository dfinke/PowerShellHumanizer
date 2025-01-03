<#
.SYNOPSIS
    Return a string representing time relative a given Date.
.DESCRIPTION
    Return a string representing time relative a given Date.
.PARAMETER Date
    A DateTime object. Default is Now.
.EXAMPLE
    ConvertTo-HumanDate
    now
.EXAMPLE
    ConvertTo-HumanDate (Get-Date).AddDays(-1)
    yesterday
.EXAMPLE
    ConvertTo-HumanDate (Get-Date).AddDays(-12)
    12 days ago
#>
function ConvertTo-HumanDate {
    [CmdletBinding()]
    [Alias('ConvertTo-DateWord')]
    [OutputType('string')]
    param(
        [Parameter(Position = 0, ValueFromPipeline)]
        [datetime]$Date = (Get-Date)
    )

    Process {
        [Humanizer.DateHumanizeExtensions]::Humanize( $Date , $false )
    }
}