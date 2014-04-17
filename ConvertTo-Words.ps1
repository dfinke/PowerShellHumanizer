function ConvertTo-Words {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [int]$number
    )
    
    Process {
        [Humanizer.NumberToWordsExtension]::ToWords($number)
    }
}
