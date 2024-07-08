
Describe 'Functions' {
    BeforeAll {
        Import-Module "$PSScriptRoot/../publish/PowerShellHumanizer" -Force
    }

    AfterAll {
        Remove-Module PowerShellHumanizer
    }

    Context 'Pluralize' {
        It 'Should convert man to men' {
            ConvertTo-Plural man | Should -Be 'men'
        }
        It 'Should convert an array' {
            $output = Write-Output person man woman | ConvertTo-Plural
            $output[0] | Should -Be 'people'
            $output[1] | Should -Be 'men'
            $output[2] | Should -Be 'women'
        }
    }

    Context 'Singularize' {
        It 'Should convert <given> to <expect>' -ForEach @(
            @{given = 'people'; expect = 'person' }
            @{given = 'men'; expect = 'man' }
            @{given = 'women'; expect = 'woman' }
            @{given = 'geese'; expect = 'goose' }
            @{given = 'indicies'; expect = 'indicy' }
            @{given = 'oxen'; expect = 'ox' }
            @{given = 'knives'; expect = 'knife' }
        ) {
            $result = $given | ConvertTo-Singular
            $result | Should -Be $expect
        }

    }

    Context 'Hyphenate' {
        It 'Should convert to a hyphenated string' {

            "Continuing To Make Powershell A Bit More Human" |
            ConvertTo-HyphenatedString |
            Should -Be 'continuing-to-make-powershell-a-bit-more-human'
        }

    }

    Context 'Number to ordinal words' {
        It 'Should convert to words' {
            ConvertTo-OrdinalWord 121 | Should -Be 'hundred and twenty-first'
        }
        It 'Should convert a range to words' {
            $output = 120..122 | ConvertTo-OrdinalWord
            $output[0] | Should -Be 'hundred and twentieth'
            $output[1] | Should -Be 'hundred and twenty-first'
            $output[2] | Should -Be 'hundred and twenty-second'
        }
    }

    Context 'Quantity' {
        It 'Should return "<expected>" with -quantity <quant> -string "<string>"' -ForEach @(
            @{quant = 1; string = 'widgets'; expected = 'one widget' }
            @{quant = 2; string = 'widgets'; expected = 'two widgets' }
        ) {
            $result = ConvertTo-Quantity -quantity $quant -string $string -showQuantityAs "Words"
            $result | Should -Be $expected
        }
    }
}

Describe 'Type Extension Methods' {

    Context 'Strings' {

        It 'Should transform to Upper Case' {
            'then add nodes under it.'.Transform("UpperCase") | Should -Be 'THEN ADD NODES UNDER IT.'
        }
        It 'Should convert to Title Case' {
            'then add nodes under it.'.ToTitleCase() | Should -Be 'Then Add Nodes Under It.'
        }
        It 'Should convert from Title Case' {
            'FromTitleCase'.Underscore() | Should -Be 'from_title_case'
        }
        It 'Should truncate words' {
            'then add nodes under it.'.Truncate(3, "Words") | Should -Match 'then add nodes\W$'
        }
        It 'Should truncate characters' {
            'then add nodes under it.'.Truncate(3, "Characters") | Should -Match 'th\W$'
        }
        It 'Should truncate with optional character' {
            'then add nodes under it.'.Truncate(7, "Characters", '-') | Should -Be 'then ad-'
        }
        It 'Should Dehumanize' {
            'then add nodes under it.'.Dehumanize() | Should -Be 'ThenAddNodesUnderIt'
        }
        It 'Should provide quanity: # word' {
            'string'.ToQuantity(50) | Should -Be '50 strings'
        }
        It 'Should provide quantity: words' {
            'string'.ToQuantity(50, "Words") | Should -Be 'fifty strings'
        }
        It 'Should convert Year to roman numerals' {
            (Get-Date -Year 2024 ).Year.ToRoman() | Should -Be 'MMXXIV'
        }
    }

    Context 'Integers' {
        It 'Should ordanalize' {
            (3).Ordinalize() | Should -Be '3rd'
        }
        It 'Should convert to word' {
            (3).ToWords() | Should -Be 'three'
        }
        It 'Should do math in weeks' {
            (Get-Date 2/13/2016) + (3).Weeks -eq (Get-Date 3/5/2016) | Should -Be $true
        }
    }

    Context 'TimeSpan' {
        BeforeAll {
            $past = (Get-Date 2/13/2016).AddMinutes(-1).AddSeconds(-20)
            $time = (Get-Date 2/13/2016) - $past
        }

        It 'Should simplify TimeSpan objects' {
            $time.Humanize() | Should -Be '1 minute'
        }
        It 'Should simplify TimeSpan objects with selectable precision' {
            $time.Humanize(2) | Should -Be '1 minute, 20 seconds'
        }
    }

    Context 'DateTime' {
        It 'Should display Now as now when UTC is false' {
            (Get-Date).Humanize() | Should -Be 'now'
        }
        It 'Should display Now as hours ago when UTC is true' -Skip:($env:CI -eq 'True') {
            (Get-Date).Humanize($true) | Should -Match 'hours'
        }
    }
}

Describe 'Custom Formats' {

    Context 'TimeSpan' {
        It 'Should display 1 hour' {
            (([TimeSpan]::new(1, 0, 0)) | Out-String).trim() | Should -Be '1 hour'
        }
    }

    Context 'FileSystem' {
        BeforeAll {
            $listAlphaLower = [char[]](97..122)
            $listAlphaUpper = [char[]](65..90)
            $listNumber = 0..9
            $charset = $listAlphaLower + $listAlphaUpper + $listNumber

            $content = (1..(1kb)).ForEach({ Get-Random $charset })
            -join $content | Set-Content TestDrive:\testfile.txt
            $testData = Get-Item TestDrive:\testfile.txt | Out-String
        }
        It 'Should display 1 KB' {
            $testData | Should -Match '1 KB .? {0,2}testfile\.txt'
        }
    }
}