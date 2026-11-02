# ==============================================================================
# SCRIPT DE AUTOMATIZACIÓN DE USUARIOS, GRUPOS Y ESTRUCTURA DE DIRECTORIOS
# Materia: Administrador de Servidores - Tarea 3.1
# ==============================================================================

# 1. Definición de variables globales y ruta base
$BaseDir = "C:\ServidorLocal"
$PasswordTemporal = ConvertTo-SecureString "TempPass123*" -AsPlainText -Force

# 2. Creación automatizada de la estructura de directorios departamentales
$Departamentos = @("Sistemas", "Finanzas", "Operaciones")
foreach ($dep in $Departamentos) {
    $Path = Join-Path $BaseDir $dep
    if (!(Test-Path $Path)) {
        New-Item -Path $Path -ItemType Directory -Force
        Write-Host "[+] Directorio creado con éxito: $Path" -ForegroundColor Green
    }
}

# 3. Creación automatizada de grupos locales de seguridad
$Grupos = @("Grp_Sistemas", "Grp_Finanzas", "Grp_Operaciones")
foreach ($g in $Grupos) {
    if (!(Get-LocalGroup -Name $g -ErrorAction SilentlyContinue)) {
        New-LocalGroup -Name $g -Description "Grupo de seguridad local para el departamento de $g"
        Write-Host "[+] Grupo local creado: $g" -ForegroundColor Cyan
    }
}

# 4. Creación automatizada de usuarios y asignación de directivas
$Usuarios = @(
    @{ User = "sys_admin1"; Group = "Grp_Sistemas"; Dep = "Sistemas" },
    @{ User = "fin_user1"; Group = "Grp_Finanzas"; Dep = "Finanzas" },
    @{ User = "ope_user1"; Group = "Grp_Operaciones"; Dep = "Operaciones" }
)

foreach ($u in $Usuarios) {
    if (!(Get-LocalUser -Name $u.User -ErrorAction SilentlyContinue)) {
        # Creación de usuario local con contraseña temporal
        New-LocalUser -Name $u.User -Password $PasswordTemporal -FullName "Usuario de $($u.Dep)" -Description "Cuenta automatizada para $($u.Dep)"
        
        # Forzar cambio de contraseña en el primer inicio de sesión
        Set-LocalUser -Name $u.User -PasswordNeverExpires $false
        
        # Asignación a grupo secundario correspondiente
        Add-LocalGroupMember -Group $u.Group -Member $u.User
        Write-Host "[+] Usuario creado y asignado exitosamente: $($u.User) -> $($u.Group)" -ForegroundColor Yellow
    }
}

Write-Host "`n[!] Proceso de automatización completado con éxito." -ForegroundColor Magenta