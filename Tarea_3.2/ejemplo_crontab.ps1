# Ejemplo de automatización / Equivalente a crontab en Windows (Programador de Tareas)
# Ejecución diaria automática a las 2:00 AM ejecutando el script de respaldo con privilegios de SYSTEM
$Action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-ExecutionPolicy Bypass -File C:\Users\Usuario\Desktop\Unidad_3\Tarea_3.2\backup.ps1"
$Trigger = New-ScheduledTaskTrigger -Daily -At 2:00AM
Register-ScheduledTask -TaskName "RespaldoAutomaticoServidor" -Action $Action -Trigger $Trigger -User "SYSTEM" -Force