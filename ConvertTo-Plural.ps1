function ConvertTo-Plural {
    param(
        [Parameter(ValueFromPipeline=$true)]
        $Word
    )

    Process {
        [Humanizer.InflectorExtensions]::Pluralize($word)
    }
}
