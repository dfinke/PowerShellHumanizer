PowerShell Humanizer
-
This PowerShell module wraps [Mehdi Khalili's .NET Humanizer](https://github.com/MehdiK/Humanizer).

> Humanizer meets all your .NET needs for manipulating and displaying strings, enums, dates, times, timespans, numbers and quantities [http://humanizr.net](http://humanizr.net)

Install
-
To install in your personal modules folder (e.g. ~\Documents\WindowsPowerShell\Modules), run:

```powershell
iex (new-object System.Net.WebClient).DownloadString('https://raw.github.com/dfinke/PowerShellHumanizer/master/Install.ps1')
```

Using PowerShell Humanizer
-
![image](https://raw.github.com/dfinke/PowerShellHumanizer/master/Videos/TryPowerShellHumanizer.gif)


Examples
-
### Pluralize
```powershell
PS C:\> ConvertTo-Plural man
men

PS C:\> echo person man woman | ConvertTo-Plural
people
men
women
```
### Singularize
```powershell
PS C:\> echo people men women geese indicies oxen knives | ConvertTo-Singular
person
man
woman
goose
indicy
ox
knife
```
### Number to ordinal words
```powershell
PS C:\> ConvertTo-OrdinalWords 121
hundred and twenty first

PS C:\> 120..130 | ConvertTo-OrdinalWords
hundred and twentieth
hundred and twenty first
hundred and twenty second
hundred and twenty third
hundred and twenty fourth
hundred and twenty fifth
hundred and twenty sixth
hundred and twenty seventh
hundred and twenty eighth
hundred and twenty ninth
hundred and thirtieth
```

### String Extension Methods
```powershell
PS C:\> Register-HumanizerString

PS C:\> 'then add nodes under it.'.ToTitleCase
Then Add Nodes Under It.

PS C:\> 'then add nodes under it.'.TruncateWords(3)
then add nodes…

PS C:\> 'then add nodes under it.'.TruncateCharacters(3)
th…

PS C:\> 'then add nodes under it.'.TruncateCharacters(7, '-')
then a-

PS C:\> 'then add nodes under it.'.Dehumanize
ThenAddNodesUnderIt.

PS C:\> 'string'.ToQuantity(50)
50 strings

PS C:\> 'string'.ToQuantity(50, "word")
fifty strings
```

### Integer Extension Methods
```powershell
PS C:\> Register-HumanizerInteger

PS C:\> (3).Ordinalize
3rd

PS C:\> (3).ToWords
three

PS C:\> Write-Host "Now: $(Get-Date). In three weeks: $((Get-Date) + (3).Weeks)"
Now: 04/16/2014 09:18:10. In three weeks: 05/07/2014 09:18:10
```

### DateTime Extension Methods
```powershell
PS C:\> (Get-Date).Humanize()
4 hours ago

PS C:\> (Get-Date).Humanize($false)
now

PS C:\> $past = Get-Date
PS C:\> $past.Humanize($false, (get-date))
13 minutes ago
```