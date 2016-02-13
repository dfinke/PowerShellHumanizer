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
        It 'Should convert' {
        }

    }
    Context 'Hyphenate' {
        It 'Should convert' {
        }

    }
    Context 'Number to ordinal words' {
        It 'Should convert' {
        }
    }
}

Describe 'Type Extension Methods' {

}

Describe 'Custom Formats' {

}