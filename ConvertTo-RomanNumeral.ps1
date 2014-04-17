function ConvertTo-RomanNumeral {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [int]$Number
    )
    
    Process {
        [Humanizer.RomanNumeralExtensions]::ToRoman($Number) 
    }
}