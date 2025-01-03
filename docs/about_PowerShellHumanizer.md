# Topic

about_PowerShellHumanizer

## Short Description

This PowerShell module wraps [Mehdi Khalili's .NET Humanizer](https://github.com/MehdiK/Humanizer).

## Long Description

Humanizer meets all your .NET needs for manipulating and displaying strings, enums, dates, times, timespans, numbers and quantities [http://humanizr.net](http://humanizr.net)

## String Extension Methods

- `.Humanize()`
- `.Humanize([Humanizer.LetterCasing]LetterCasing <"AllCaps","Sentence","Title","LowerCase">)`
- `.Transform([string]Case <"SentenceCase","TitleCase","LowerCase","UpperCase">)`
- `.ToSentenceCase()`
- `.ToTitleCase()`
- `.ToQuantity([int]Count)`
- `.ToQuantity([int]Count, [Humanizer.ShowQuantityAs]ShowQuantityAs <"Numeric","Word">)`
- `.Dehumanize()`
- `.Underscore()`
- `.FromRoman()`
- `.Truncate([int]Length)`
- `.Truncate([int]Length, [string]Truncator <"Characters","Words">)`
- `.Truncate([int]Length, [string]Truncator <"Characters","Words">, [string]TruncationString)`
- `.Truncate([int]Length, [string]Truncator <"Characters","Words">, [string]TruncationString, [Humanizer.TruncateFrom]From <"Left","Right">)`

## Integer Extension Methods

- `.Ordinalize()`
- `.ToWords()`
- `.ToRoman()`

## Integer Extension Properties

- `.Weeks`
- `.Days`
- `.Hours`
- `.Minutes`
- `.Seconds`
- `.Milliseconds`

## Timespan Extension Methods

- `.Humanize([int]Precision)`

## Datetime Extension Methods

- `.Humanize([bool]UTC)`
