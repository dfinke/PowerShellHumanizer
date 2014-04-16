<#
.Synopsis
   Add Humanizer extension methods to System.String
.DESCRIPTION
   Add numerous ScriptMethod and ScriptProperty members to System.String to 
   provide access to Humanizer string transform functionality.
.EXAMPLE
    PS C:\> Register-HumanizerString
.EXAMPLE
    PS C:\> 'then add nodes under it.'.ToTitleCase
    Then Add Nodes Under It.
.EXAMPLE
    PS C:\> 'then add nodes under it.'.TruncateWords(3)
    then add nodes…
.EXAMPLE
    PS C:\> 'then add nodes under it.'.TruncateCharacters(3)
    th…
.EXAMPLE
    PS C:\> 'then add nodes under it.'.TruncateCharacters(7, '-')
    then a-

    Truncate length included the length of the truncationString. So this outputs
    6 original characters plus the '-' (hyphen).
.EXAMPLE
    PS C:\> 'then add nodes under it.'.Dehumanize
    ThenAddNodesUnderIt.
.EXAMPLE
    PS C:\> 'string'.ToQuantity(50)
    50 strings
.EXAMPLE
    PS C:\> 'string'.ToQuantity(50, "word")
    fifty strings
#>
function Register-HumanizerString
{
    [CmdletBinding()]
    Param
    (
        # TODO: Handle The member is already present
    )

    # TODO: Handle 'The member Dehumanize is already present'
    Write-Verbose 'Adding "ToQuantityExtensions" to [System.String]'
    Update-TypeData -TypeName System.String `
        -MemberType ScriptMethod `
        -MemberName ToQuantity `
        -value { switch ($args.Count) {
                1 { [Humanizer.ToQuantityExtensions]::ToQuantity($this, $args[0]) }
                2 { [Humanizer.ToQuantityExtensions]::ToQuantity($this, $args[0], $args[1]) }
                default { throw "No overload for ToQuantity takes the specified number of parameters." }
              }}

    Write-Verbose 'Adding "Dehumanize" to [System.String]'
    Update-TypeData -TypeName System.String `
        -MemberType ScriptProperty `
        -MemberName Dehumanize `
        -value { [Humanizer.StringDehumanizeExtensions]::Dehumanize($this) }

    Write-Verbose 'Adding "StringHumanizeExtensions" to [System.String]'
    Update-TypeData -TypeName System.String `
        -MemberType ScriptProperty `
        -MemberName Humanize `
        -value { [Humanizer.StringHumanizeExtensions]::Humanize($this) }      
              
    Write-Verbose 'Adding "ToSentenceCase" to [System.String]'
    Update-TypeData -TypeName System.String `
        -MemberType ScriptProperty `
        -MemberName ToSentenceCase `
        -value {  [Humanizer.CasingExtensions]::ApplyCase($this, [Humanizer.LetterCasing]::Sentence) }

    Write-Verbose 'Adding "ToTitleCase" to [System.String]'
    Update-TypeData -TypeName System.String `
        -MemberType ScriptProperty `
        -MemberName FromRoman `
        -value {  [Humanizer.RomanNumeralExtensions]::FromRoman($this, [Humanizer.LetterCasing]::Title) }

    Write-Verbose 'Adding "ToTitleCase" to [System.String]'
    Update-TypeData -TypeName System.String `
        -MemberType ScriptProperty `
        -MemberName ToTitleCase `
        -value {  [Humanizer.CasingExtensions]::ApplyCase($this, [Humanizer.LetterCasing]::Title) }

    Write-Verbose 'Adding "Truncator" to [System.String]'
    Update-TypeData -TypeName System.String `
        -MemberType ScriptMethod `
        -MemberName TruncateCharacters `
        -value { switch ($args.Count) {
                1 { [Humanizer.Truncator]::Truncate($this, [int]$args[0]) }
                2 { [Humanizer.Truncator]::Truncate($this, [int]$args[0], [string]$args[1]) }
                default { throw "No overload for Truncate takes the specified number of parameters." }
              }}
    Update-TypeData -TypeName System.String `
        -MemberType ScriptMethod `
        -MemberName TruncateWords `
        -value { switch ($args.Count) {
                1 { [Humanizer.Truncator]::Truncate($this, [int]$args[0], [Humanizer.Truncator]::FixedNumberOfWords) }
                2 { [Humanizer.Truncator]::Truncate($this, [int]$args[0], [string]$args[1], [Humanizer.Truncator]::FixedNumberOfWords) }
                default { throw "No overload for Truncate takes the specified number of parameters." }
              }}

    Write-Verbose 'Adding "OrdinalizeExtensions" to [System.String]'
    Update-TypeData -TypeName System.String `
        -MemberType ScriptMethod `
        -MemberName Ordinalize `
        -value { switch ($args.Count) {
                1 { [Humanizer.OrdinalizeExtensions]::Ordinalize($this, $args[0]) }
                2 { [Humanizer.OrdinalizeExtensions]::Ordinalize($this, $args[0], $args[1]) }
                default { throw "No overload for Ordinalize takes the specified number of parameters." }
              }}
}

<#
.Synopsis
   Add Humanizer extension methods to System.Int32
.DESCRIPTION
   Add numerous ScriptMethod and ScriptProperty members to System.Int32 to 
   provide access to Humanizer number to string transform functionality.
.EXAMPLE
    PS C:\> Register-HumanizerInteger
.EXAMPLE
    PS C:\temp> (3).Ordinalize
    3rd
.EXAMPLE
    PS C:\temp> (3).ToWords
    three
#>
function Register-HumanizerInteger
{
    [CmdletBinding()]
    Param
    (
        #TODO: Parameters to enable select Extentions
    )

    # TODO: Handle The member is already present

    Write-Verbose 'Adding "OrdinalizeExtensions" to [System.Int32]'
    Update-TypeData -TypeName System.Int32 `
        -MemberType ScriptProperty `
        -MemberName Ordinalize `
        -value { [Humanizer.OrdinalizeExtensions]::Ordinalize($this) }

    Write-Verbose 'Adding "NumberToWordsExtension" to [System.Int32]'
    Update-TypeData -TypeName System.Int32 `
        -MemberType ScriptProperty `
        -MemberName ToWords `
        -value { [Humanizer.NumberToWordsExtension]::ToWords($this) }
    <# Update-TypeData -TypeName System.Int32 ` # In the source, but not in the binary
        -MemberType ScriptProperty `
        -MemberName ToOrdinalWords `
        -value { [Humanizer.NumberToWordsExtension]:: } #>


    Write-Verbose 'Adding "NumberToTimeSpanExtensions" to [System.Int32]'
    Update-TypeData -TypeName System.Int32 `
        -MemberType ScriptProperty `
        -MemberName Weeks `
        -value { [Humanizer.NumberToTimeSpanExtensions]::Weeks($this) }
    Update-TypeData -TypeName System.Int32 `
        -MemberType ScriptProperty `
        -MemberName Days `
        -value { [Humanizer.NumberToTimeSpanExtensions]::Days($this) }
    Update-TypeData -TypeName System.Int32 `
        -MemberType ScriptProperty `
        -MemberName Hours `
        -value { [Humanizer.NumberToTimeSpanExtensions]::Hours($this) }
    Update-TypeData -TypeName System.Int32 `
        -MemberType ScriptProperty `
        -MemberName Minutes `
        -value { [Humanizer.NumberToTimeSpanExtensions]::Minutes($this) }
    Update-TypeData -TypeName System.Int32 `
        -MemberType ScriptProperty `
        -MemberName Seconds `
        -value { [Humanizer.NumberToTimeSpanExtensions]::Seconds($this) }
    Update-TypeData -TypeName System.Int32 `
        -MemberType ScriptProperty `
        -MemberName Milliseconds `
        -value { [Humanizer.NumberToTimeSpanExtensions]::Milliseconds($this) }

    Write-Verbose 'Adding "RomanNumeralExtensions" to [System.Int32]'
    Update-TypeData -TypeName System.Int32 `
        -MemberType ScriptProperty `
        -MemberName ToRoman `
        -value { [Humanizer.RomanNumeralExtensions]::ToRoman($this) }

}

<#
.Synopsis
   Add Humanizer extension methods to System.TimeSpan
.DESCRIPTION
   Adds ScriptMethod members to System.TimeSpan to 
   provide access to Humanizer TimeSpan to string transform functionality.
.EXAMPLE
    PS C:\> $past = get-date
    
    PS C:\> ((get-date)-$past).Humanize()
    1 minute

    The Defaulte precision is 1 which means the largest unit is returned.
.EXAMPLE
    PS C:\> ((get-date)-$past).Humanize(2)
    1 minute, 42 seconds

    With a precision of 2, the second largest unit is also returned.
#>
function Register-HumanizerTimeSpan
{
    [CmdletBinding()]
    Param
    (
        #TODO: Parameters to enable select Extentions
    )

    # TODO: Handle The member is already present

    Write-Verbose 'Adding "TimeSpanHumanizeExtensions" to [System.TimeSpan]'
    Update-TypeData -TypeName System.TimeSpan `
        -MemberType ScriptMethod `
        -MemberName Humanize `
        -value { switch ($args.Count) {
                0 { [Humanizer.TimeSpanHumanizeExtensions]::Humanize($this) }
                1 { [Humanizer.TimeSpanHumanizeExtensions]::Humanize($this, [int]$args[0]) }
                default { throw "No overload for Humanize takes the specified number of parameters." }
              }}
}

<#
.Synopsis
   Add Humanizer extension methods to System.DateTime
.DESCRIPTION
   Adds ScriptMethod members to System.DateTime to 
   provide access to Humanizer DateTime to string transform functionality.
.EXAMPLE
    PS C:\> (Get-Date).Humanize()
    4 hours ago

    The default behavio is to compare the input to UTC time.
.EXAMPLE
    PS C:\> (Get-Date).Humanize($false)
    now

    Set utcDate parameter to $false.
.EXAMPLE
    PS C:\> $past.Humanize($false, (get-date))
    13 minutes ago

    Compare one date to another using local time.
#>
function Register-HumanizerDateTime
{
    [CmdletBinding()]
    Param
    (
        #TODO: Parameters to enable select Extentions
    )

    # TODO: Handle The member is already present

    Write-Verbose 'Adding "DateHumanizeExtensions" to [System.DateTime]'
    Update-TypeData -TypeName System.DateTime `
        -MemberType ScriptMethod `
        -MemberName Humanize `
        -value { switch ($args.Count) {
                0 { [Humanizer.DateHumanizeExtensions]::Humanize($this) }
                1 { [Humanizer.DateHumanizeExtensions]::Humanize($this, [bool]$args[0]) }
                2 { [Humanizer.DateHumanizeExtensions]::Humanize($this, [bool]$args[0], [DateTime]$args[1]) }
                default { throw "No overload for Humanize takes the specified number of parameters." }
              }}
}

<#
.Synopsis
   Register Humanizer extension methods
.DESCRIPTION
   Add numerous ScriptMethod and ScriptProperty members to existing
   Types to provide access to Humanizer string transform functionality.
#>
function Register-HumanizerAllTypes
{
    [CmdletBinding()]
    Param
    (
    )

    Add-HumanizerLibrary
    Register-HumanizerString
    Register-HumanizerInteger
    Register-HumanizerTimeSpan
    Register-HumanizerDateTime
}

Export-ModuleMember -Function Add-HumanizerLibrary, Register-HumanizerString, Register-HumanizerInteger, Register-HumanizerTimeSpan, Register-HumanizerDateTime, Register-HumanizerAllTypes