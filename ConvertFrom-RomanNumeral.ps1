function ConvertFrom-RomanNumeral {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [string]$RomanNumeral
    )
    
    Process {
        [Humanizer.RomanNumeralExtensions]::FromRoman($RomanNumeral) 
    }
}