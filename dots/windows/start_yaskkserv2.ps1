$taskName = "StartYaskkserv2"
$programPath = "C:\tools\yaskkserv2\yaskkserv2.exe"
$configPath = "$Env:USERPROFILE\.skk\win_yaskkserv2.conf"
$action = New-ScheduledTaskAction -Execute $programPath -Argument "--config-filename `"$configPath`""
$trigger = New-ScheduledTaskTrigger -AtLogon
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -DontStopOnIdleEnd -StartWhenAvailable -Hidden

Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Settings $settings -Force
