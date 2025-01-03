# ConvertTo-Casing

Format the given string with the given case. Options are Title, AllCaps, LowerCase, and Sentence.

## Parameters

### Parameter Set 1

- `[String[]]` **Target** _One or more strings to format._ Mandatory, ValueFromPipeline
- `[Switch]` **Case** _The target casing. Options are Title, AllCaps, LowerCase, and Sentence. Default is Title._ 

## Examples

### Example 1



```powershell
"the powershell gallery" | ConvertTo-Casing -Case Title
the Powershell Gallery
```

## Outputs

- `string`
