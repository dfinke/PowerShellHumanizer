# ConvertTo-HumanDate

Return a string representing time relative a given Date.

## Parameters

### Parameter Set 1

- `[DateTime]` **Date** _A DateTime object. Default is Now._ ValueFromPipeline

## Examples

### Example 1



```powershell
ConvertTo-HumanDate
now
```
### Example 2



```powershell
ConvertTo-HumanDate (Get-Date).AddDays(-1)
yesterday
```
### Example 3



```powershell
ConvertTo-HumanDate (Get-Date).AddDays(-12)
12 days ago
```

## Outputs

- `string`
