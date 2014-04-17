function ConvertTo-HumanDate {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [datetime]$Date=(Get-Date)
    )
    
    Process {
        [Humanizer.DateHumanizeExtensions]::Humanize( $Date , $false )
    }
}
