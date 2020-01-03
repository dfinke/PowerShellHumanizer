<!-- chapter start -->

# PowerShell Humanizer

The PowerShell Humanizer wraps Humanizer: meets all your .NET needs for manipulating and displaying strings, enums, dates, times, timespans, numbers and quantities.

- [GitHub Repo](https://github.com/dfinke/PowerShellHumanizer)
- [On the PowerShell Gallery](https://www.powershellgallery.com/packages/PowerShellHumanizer)

Below, you can try it our for yourself.

## Install the module

```ps
# exclude results

# Install-Module PowerShellHumanizer -Force
```

## Pluralize

```ps
ConvertTo-Plural man
```

```ps
'person','man','woman' | ConvertTo-Plural
```

## Singularize

```ps
'people','men','women','geese','indicies','oxen','knives' | ConvertTo-Singular
```

## Number to ordinal words

```ps
ConvertTo-OrdinalWords 121
```

```ps
120..130 | ConvertTo-OrdinalWords
```

## String Extension Methods

```ps
'then add nodes under it.'.ToTitleCase()
```

```ps
'FromTitleCase'.Underscore()
```

```ps
'then add nodes under it.'.Dehumanize()
```

```ps
'string'.ToQuantity(50)
```

```ps
'string'.ToQuantity(50, "word")
```

```ps
(Get-Date).Year.ToRoman()
```

```ps
(3).Ordinalize()
```

```ps
(3).ToWords()
```

```ps
$past = Get-Date
```

```ps
((Get-Date)-$past).Humanize()
```

```ps
((Get-Date)-$past).Humanize(2)
```

## DateTime Extension Methods

```ps
(Get-Date).Humanize($true)
```

```ps
(Get-Date).Humanize()
```

```ps
(get-date) - (get-date "1/1/2015")
```

```ps
$output = (get-date "1/1/2015") - (get-date)
$output
```
<!-- chapter end -->