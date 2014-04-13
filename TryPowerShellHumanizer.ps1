Import-Module PowerShellHumanizer

"ConvertTo-Quantity: {0}"       -f (1111 | ConvertTo-Quantity test -showQuantityAs Words)
"ConvertTo-HumanDate: {0}"      -f (ConvertTo-HumanDate (Get-Date).AddDays(-1) )
"ConvertTo-HumanDate: {0}"      -f (ConvertTo-HumanDate (Get-Date).AddDays(1) )
"ConvertTo-RomanNumeral: {0}"   -f (ConvertTo-RomanNumeral 42)
"ConvertFrom-RomanNumeral: {0}" -f (ConvertTo-RomanNumeral 42|ConvertFrom-RomanNumeral)
"ConvertTo-Casing: {0}"         -f (ConvertTo-Casing "some text this is" -Case Title)
"ConvertTo-Ordinal: {0}"        -f (ConvertTo-Ordinal 1111)
"ConvertTo-Singular: {0}"       -f (ConvertTo-Singular people)