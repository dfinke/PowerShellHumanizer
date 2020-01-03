<!-- chapter start -->

# PowerShell Humanizer

The PowerShell Humanizer wraps Humanizer: meets all your .NET needs for manipulating and displaying strings, enums, dates, times, timespans, numbers and quantities.

Below, you can try it our for yourself.

## Install the module

```ps
#exclude results
Install-Module PowerShellHumanizer
```

## Getting Started

### Pluralize

```ps
ConvertTo-Plural man
```

```ps
'person','man','woman' | ConvertTo-Plural
```

### Singularize

```ps
'people','men','women','geese','indicies','oxen','knives' | ConvertTo-Singular
```

<!-- chapter end -->