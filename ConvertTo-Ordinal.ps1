function ConvertTo-Ordinal {
    param(        
        [Parameter(ValueFromPipeline=$true)]
        [int]$Target
    )
    
    Process {
        [Humanizer.OrdinalizeExtensions]::Ordinalize($Target)
    }
}
