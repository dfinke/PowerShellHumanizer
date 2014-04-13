$targetPath = $PSScriptRoot

$dll = dir $targetPath -Recurse humanizer.dll

if(!$dll) {
    
    if(!(Get-Command nuget -ErrorAction SilentlyContinue)) {
        Write-Host -ForegroundColor Red "Please install nuget http://www.nuget.org/"
        return
    }

    pushd
    cd $targetPath
    nuget install humanizer
    popd
}

$dll = dir $targetPath -Recurse humanizer.dll

Add-Type -Path $dll.FullName

function ConvertTo-HumanDate {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [datetime]$Date=(Get-Date)
    )
    
    Process {
        [Humanizer.DateHumanizeExtensions]::Humanize( $Date , $false )
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

function ConvertTo-Plural {
    param(
        [Parameter(ValueFromPipeline=$true)]
        $Word
    )

    Process {
        [Humanizer.InflectorExtensions]::Pluralize($word)
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

function ConvertFrom-RomanNumeral {
    param(
        [Parameter(ValueFromPipeline=$true)]
        [string]$RomanNumeral
    )
    
    Process {
        [Humanizer.RomanNumeralExtensions]::FromRoman($RomanNumeral) 
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


function ConvertTo-Casing{
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