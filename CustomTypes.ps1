Update-TypeData -Force -TypeName String -MemberType ScriptMethod -MemberName Capitalize -Value {
    [Humanizer.To]::Transform($this, [Humanizer.To]::SentenceCase)
}

Update-TypeData -Force -TypeName String -MemberType ScriptMethod -MemberName Title -Value {
    [Humanizer.To]::Transform($this, [Humanizer.To]::TitleCase)
}

Update-TypeData -Force -TypeName String -MemberType ScriptMethod -MemberName Strip -Value {
    $this.Trim()
}

Update-TypeData -Force -TypeName String -MemberType ScriptMethod -MemberName RStrip -Value {
    $this.TrimEnd()
}

Update-TypeData -Force -TypeName String -MemberType ScriptMethod -MemberName LStrip -Value {
    $this.TrimStart()
}