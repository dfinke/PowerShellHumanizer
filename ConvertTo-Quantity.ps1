function ConvertTo-Quantity {
    param(
        [string]$string,

        [Parameter(ValueFromPipeline=$true)]
        [int]$quantity,

        [ValidateSet("None","Numeric","Words")]
        $showQuantityAs="Numeric"
    )
    
    Process {
        [Humanizer.ToQuantityExtensions]::ToQuantity($string, $quantity, $showQuantityAs)
    }
}
