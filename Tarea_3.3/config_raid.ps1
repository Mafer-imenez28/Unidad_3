# Script de configuración y simulación de almacenamiento redundante (Storage Spaces / VHD)
$RutaVHD = "C:\DiscosVirtuales"

# Verificar o crear directorio de discos virtuales
if (!(Test-Path $RutaVHD)) { 
    New-Item -ItemType Directory -Path $RutaVHD 
}

# Creación de discos virtuales para simular arreglo redundante (RAID 1 / Espejo)
New-VHD -Path "$RutaVHD\Disco1.vhdx" -SizeBytes 2GB -Fixed | Out-Null
New-VHD -Path "$RutaVHD\Disco2.vhdx" -SizeBytes 2GB -Fixed | Out-Null

Write-Host "Discos virtuales creados exitosamente en $RutaVHD para el arreglo redundante." -ForegroundColor Green