function ConvertTo-Casing {
    param(        
        [Parameter(ValueFromPipeline=$true)]
        [string]$Target,
        [ValidateSet("Title","AllCaps","LowerCase","Sentence")]
        $Case="Title"
    )
    
    Process {
        [Humanizer.CasingExtensions]::ApplyCase($Target, $Case)
        
    }
}