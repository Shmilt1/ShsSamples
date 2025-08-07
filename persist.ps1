$payload = "VwByAGkAdABlAC0ASABvAHMAdAAgAGgAaQAhAA==" # Write-Host hi!

$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -WindowStyle Hidden -EncodedCommand %payload"
$trigger = New-ScheduledTaskTrigger -AtLogOn
$settings = New-ScheduledTaskSettingsSet -StartWhenAvailable -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -Hidden

Register-ScheduledTask -TaskName "MicrosoftDefenderScan" -Action $action -Trigger $trigger -Settings $settings -User $env:USERNAME -Force
