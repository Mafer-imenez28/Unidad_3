# Configuración de permisos avanzados y cuotas de disco (Windows)
# 1. Permisos avanzados en la carpeta compartida
icacls "C:\CarpetaCompartida" /inheritance:r
icacls "C:\CarpetaCompartida" /grant "Administrators:(OI)(CI)F"
icacls "C:\CarpetaCompartida" /grant "Usuarios:(OI)(CI)(M)"

# 2. Configuración de cuotas en disco
fsutil quota track C:
fsutil quota enforce C:
fsutil quota modify C: 104857600 524288000 Everyone