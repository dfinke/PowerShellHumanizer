Update-TypeData -Force -TypeName String -MemberType ScriptMethod -MemberName Capitalize -Value {
    param($propertyName, $lower, $upper)
 
    [Humanizer.To]::Transform($this, [Humanizer.To]::SentenceCase   )
}

Update-TypeData -Force -TypeName String -MemberType ScriptMethod -MemberName Title -Value {
    param($propertyName, $lower, $upper)
 
    [Humanizer.To]::Transform($this, [Humanizer.To]::TitleCase)
}

Update-TypeData -Force -TypeName String -MemberType ScriptMethod -MemberName Strip -Value {
    param($propertyName, $lower, $upper)
 
    $this.Trim()
}

Update-TypeData -Force -TypeName String -MemberType ScriptMethod -MemberName RStrip -Value {
    param($propertyName, $lower, $upper)
 
    $this.TrimEnd()
}

Update-TypeData -Force -TypeName String -MemberType ScriptMethod -MemberName LStrip -Value {
    param($propertyName, $lower, $upper)

    $this.TrimStart()
}