$ModuleDll = Get-ChildItem -Path $PSScriptRoot -Include 'humanizer.dll' | ForEach-Object FullName

Add-Type -Path $ModuleDll

$Types = @("$PSScriptRoot\String.types.ps1xml", 
    "$PSScriptRoot\Int.types.ps1xml", 
    "$PSScriptRoot\TimeSpan.types.ps1xml",
    "$PSScriptRoot\DateTime.types.ps1xml",
    "$PSScriptRoot\CmdletInfo.types.ps1xml")

Update-TypeData -PrependPath $Types

# Must call Update-FormatData with -PrependPath to override built-in defined formats
Update-FormatData -PrependPath "$PSScriptRoot\TimeSpan.format.ps1xml"
Update-FormatData -PrependPath "$PSScriptRoot\FileInfo.format.ps1xml"

function ConvertFrom-RomanNumeral {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [string]$RomanNumeral
    )

    Process {
        [Humanizer.RomanNumeralExtensions]::FromRoman($RomanNumeral)
    }
}

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

function ConvertTo-HumanDate {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [datetime]$Date=(Get-Date)
    )

    Process {
        [Humanizer.DateHumanizeExtensions]::Humanize( $Date , $false )
    }
}

function ConvertTo-Ordinal {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [int]$Target
    )

    Process {
        [Humanizer.OrdinalizeExtensions]::Ordinalize($Target)
    }
}

function ConvertTo-OrdinalWords {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [int]$Target
    )

    Process {
        [Humanizer.NumberToWordsExtension]::ToOrdinalWords($Target)
    }
}

function ConvertTo-Plural {
    param(
        [Parameter(ValueFromPipeline=$true)]
        $Word
    )

    Process {
        [Humanizer.InflectorExtensions]::Pluralize($word)
    }
}

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


function ConvertTo-RomanNumeral {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [int]$Number
    )

    Process {
        [Humanizer.RomanNumeralExtensions]::ToRoman($Number)
    }
}

function ConvertTo-Singular {
    param(
        [Parameter(ValueFromPipeline=$true)]
        $Word
    )

    Process {
        [Humanizer.InflectorExtensions]::Singularize($word)
    }
}

function ConvertTo-Words {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [int]$number
    )

    Process {
        [Humanizer.NumberToWordsExtension]::ToWords($number)
    }
}

function ConvertTo-HyphenatedString {
    param(
        [Parameter(ValueFromPipeline=$true)]
        $TitleString
    )

    Process {
        [Humanizer.InflectorExtensions]::Dasherize($TitleString.Underscore())
    }
}


