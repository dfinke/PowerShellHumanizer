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

### Hyphenate
```powershell
PS C:\> "Continuing To Make Powershell A Bit More Human" | ConvertTo-HyphenatedString
continuing-to-make-powershell-a-bit-more-human
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
PS C:\> 'then add nodes under it.'.ToTitleCase()
Then Add Nodes Under It.

PS C:\> 'FromTitleCase'.Underscore()
from_title_case

PS C:\> 'then add nodes under it.'.TruncateWords(3)
then add nodes…

PS C:\> 'then add nodes under it.'.Truncate(3,"Words")
th…

PS C:\> 'then add nodes under it.'.Truncate(7, "Characters", '-') 
then a-

PS C:\> 'then add nodes under it.'.Dehumanize()
ThenAddNodesUnderIt.

PS C:\> 'string'.ToQuantity(50)
50 strings

PS C:\> 'string'.ToQuantity(50, "word")
fifty strings

PS C:\> (Get-Date).Year.ToRoman()
MMXIV
```

### Integer Extension Methods
```powershell
PS C:\> Register-HumanizerInteger

PS C:\> (3).Ordinalize()
3rd

PS C:\> (3).ToWords()
three

PS C:\> Write-Host "Now: $(Get-Date). In three weeks: $((Get-Date) + (3).Weeks)"
Now: 04/16/2014 09:18:10. In three weeks: 05/07/2014 09:18:10
```

### TimeSpan Extension Methods
```powershell
PS C:\> $past = Get-Date

# Do some stuff

PS C:\> ((Get-Date)-$past).Humanize()
1 minute

PS C:\> ((Get-Date)-$past).Humanize(2)
1 minute, 42 seconds
```

### DateTime Extension Methods
```powershell
PS C:\> (Get-Date).Humanize()
4 hours ago

PS C:\> (Get-Date).Humanize($false)
now

PS C:\> dir | select @{Label="LastModified";Expression={$_.LastWriteTime.ToUniversalTime().Humanize()}}

LastModified                                                                                                                                                                                                                        
------------                                                                                                                                                                                                                        
7 months ago                                                                                                                                                                                                                        
7 months ago                                                                                                                                                                                                                        
7 months ago                                                                                                                                                                                                                        
7 months ago                                                                                                                                                                                                                        
one year ago                                                                                                                                                                                                                        
10 months ago              
```

### Custom TimeSpan Formats
```powershell
PS C:\> measure-command { 1..15000000}

2 seconds, 981 milliseconds

PS C:\> (get-date) - (get-date "1/1/2015")

57 weeks, 6 days, 20 hours

PS C:\> $output = (get-date "1/1/2015") - (get-date) 

PS C:\> $output

no time

PS C:\> $output | fl


Days              : -405
Hours             : -20
Minutes           : -50
Seconds           : -23
Milliseconds      : -356
Ticks             : -350670233562167
TotalDays         : -405.868325882138
TotalHours        : -9740.8398211713
TotalMinutes      : -584450.389270278
TotalSeconds      : -35067023.3562167
TotalMilliseconds : -35067023356.2167
```

### Custom FileSystem Table Format
```powershell
PS C:\> Get-ChildItem


    Directory: C:\Program Files\7-Zip


Mode     LastWritten         Length Name
----     -----------         ------ ----
da----   9 months ago               Lang
-a----   one year ago         93 KB 7-zip.chm
-a----   one year ago         79 KB 7-zip.dll
-a----   one year ago         49 KB 7-zip32.dll
-a----   one year ago          1 MB 7z.dll
-a----   one year ago        414 KB 7z.exe
-a----   one year ago        178 KB 7z.sfx
-a----   one year ago        163 KB 7zCon.sfx
-a----   one year ago        784 KB 7zFM.exe
-a----   one year ago        533 KB 7zG.exe
-a----   4 years ago          366 B descript.ion
-a----   one year ago         40 KB History.txt
-a----   one year ago          2 KB License.txt
-a----   one year ago          2 KB readme.txt
```
