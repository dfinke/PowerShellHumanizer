$here = Split-Path -Parent $MyInvocation.MyCommand.Path
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.ps1', '.psd1'
ipmo "$here\$sut" -Force

Describe 'Functions' {
    Context 'Pluralize' {
        It 'Should convert man to men' {
            ConvertTo-Plural man | Should Be 'men'
        }
        It 'Should convert an array' {
            $output = echo person man woman | ConvertTo-Plural
            $output[0] | Should Be 'people'
            $output[1] | Should Be 'men'
            $output[2] | Should Be 'women'
        }
    }
    Context 'Singularize' {
        $output = echo people men women geese indicies oxen knives | ConvertTo-Singular
        It 'Should convert to singles' {
            $output[0] | Should Be 'person'
            $output[1] | Should Be 'man'
            $output[2] | Should Be 'woman'
            $output[3] | Should Be 'goose'
            $output[4] | Should Be 'indicy'
            $output[5] | Should Be 'ox'
            $output[6] | Should Be 'knife'
        }

    }
    Context 'Hyphenate' {
        It 'Should convert to a hyphenated string' {

            "Continuing To Make Powershell A Bit More Human" |
                ConvertTo-HyphenatedString |
                Should Be 'continuing-to-make-powershell-a-bit-more-human'
        }

    }
    Context 'Number to ordinal words' {
        It 'Should convert to words' {
            ConvertTo-OrdinalWords 121 | Should Be 'hundred and twenty-first'
        }
        It 'Should convert a range to words' {
            $output = 120..122 | ConvertTo-OrdinalWords
            $output[0] | Should Be 'hundred and twentieth'
            $output[1] | Should Be 'hundred and twenty-first'
            $output[2] | Should Be 'hundred and twenty-second'
        }
    }
}

Describe 'Type Extension Methods' {
    Context 'Strings' {
        It 'Should convert to Title Case' {
            'then add nodes under it.'.ToTitleCase() | Should Be 'Then Add Nodes Under It.'
        }
        It 'Should convert from Title Case' {
            'FromTitleCase'.Underscore() | Should Be 'from_title_case'
        }
        It 'Should truncate words' {
            'then add nodes under it.'.Truncate(3,"Words") | Should Match 'then add nodes\W$'
        }
        It 'Should truncate characters' {
            'then add nodes under it.'.Truncate(3,"Characters") | Should Match 'th\W$'
        }
        It 'Should truncate with optional character' {
            'then add nodes under it.'.Truncate(7, "Characters", '-') | Should Be 'then ad-'
        }
        It 'Should Dehumanize' {
            'then add nodes under it.'.Dehumanize() | Should Be 'ThenAddNodesUnderIt'
        }
        It 'Should provide quanity: # word' {
            'string'.ToQuantity(50) | Should Be '50 strings'
        }
        It 'Should provide quantity: words' {
            'string'.ToQuantity(50, "Words") | Should Be 'fifty strings'
        }
        It 'Should convert Year to roman numerals' {
            (Get-Date).Year.ToRoman() | Should Be 'MMXVI'
        }
    }
    Context 'Integers' {
        It 'Should ordanalize' {
            (3).Ordinalize() | Should Be '3rd'
        }
        It 'Should convert to word' {
            (3).ToWords() | Should Be 'three'
        }
        It 'Should do math in weeks' {
            (Get-Date 2/13/2016) + (3).Weeks -eq (Get-Date 3/5/2016) | Should Be $true
        }
    }
    Context 'TimeSpan' {
        $past = (Get-Date 2/13/2016).AddMinutes(-1).AddSeconds(-20)
        $time = (Get-Date 2/13/2016) - $past
        It 'Should simplify TimeSpan objects' {
            $time.Humanize() | Should Be '1 minute'
        }
        It 'Should simplify TimeSpan objects with selectable precision' {
            $time.Humanize(2) | Should Be '1 minute, 20 seconds'
        }
    }
    Context 'DateTime' {
        It 'Should display Now as now when UTC is false' {
            (Get-Date).Humanize($false) | Should Be 'now'
        }
    }
}

Describe 'Custom Formats' {
    Context 'TimeSpan' {
        It 'Should display 1 hour' {
            (([TimeSpan]::new(1,0,0))|Out-String).trim() | Should Be '1 hour'
        }
    }
    Context 'FileSystem' {
        $chars = [char[]] ([char]'0'..[char]'9' + [char]'A'..[char]'Z' + [char]'a'..[char]'z')
        $chars = $chars * 126
        (1..(1kb/128)).foreach({-join (Get-Random $chars -Count 126) | Add-Content TestDrive:\testfile.txt })
        It 'Should display 1 KB' {
            ((Get-ChildItem TestDrive:\testfile.txt) | Out-String) | Should Match "1 KB testfile.txt"
        }
    }
}

Remove-Module PowerShellHumanizer