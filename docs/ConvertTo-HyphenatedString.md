# ConvertTo-HyphenatedString

Convert a string to a Hyphenated string.

## Parameters

### Parameter Set 1

- `[String]` **String** _A string to convert._ Mandatory, ValueFromPipeline

## Examples

### Example 1



```powershell
ConvertTo-HyphenatedString "verb noun"
verb-noun
```
### Example 2



```powershell
ConvertTo-HyphenatedString PowerShellHumanizer
power-shell-humanizer
```

## Notes

This requires the input string to have some word sepration. Either whitespace or Title case.

## Outputs

- `string`
