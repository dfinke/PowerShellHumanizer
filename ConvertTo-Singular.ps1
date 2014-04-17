function ConvertTo-Singular {
    param(
        [Parameter(ValueFromPipeline=$true)]
        $Word
    )

    Process {
        [Humanizer.InflectorExtensions]::Singularize($word)
    }
}
