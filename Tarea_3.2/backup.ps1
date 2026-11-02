# 1. Definir las carpetas de origen y destino
$Origen = "C:\CarpetaCompartida"
$Destino = "C:\Backups"

# 2. Crear una fecha y hora actual para el archivo ZIP
$Fecha = Get-Date -Format "yyyy-MM-dd_HH-mm-ss"
$NombreZip = "Backup_$Fecha.zip"
$RutaZip = Join-Path $Destino $NombreZip
$LogFile = Join-Path $Destino "backup.log"

# 3. Verificar si la carpeta de respaldos existe; si no, crearla
if (!(Test-Path $Destino)) {
    New-Item -ItemType Directory -Path $Destino | Out-Null
}

# 4. Intentar comprimir la carpeta y registrar el resultado
try {
    Compress-Archive -Path "$Origen\*" -DestinationPath $RutaZip -Force
    $Mensaje = "[$((Get-Date))] ÉXITO: Respaldo creado correctamente en $RutaZip"
    Write-Output $Mensaje
    Add-Content -Path $LogFile -Value $Mensaje
}
catch {
    $Mensaje = "[$((Get-Date))] ERROR: Falló el respaldo. Detalle: $_"
    Write-Error $Mensaje
    Add-Content -Path $LogFile -Value $Mensaje
}