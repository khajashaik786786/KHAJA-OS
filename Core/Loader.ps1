# ===============================
# KHAJA OS v5 Loader
# ===============================


$Root = Split-Path $PSScriptRoot -Parent



# ===============================
# CORE
# ===============================

Write-Host ""
Write-Host "Loading Core..." -ForegroundColor Cyan


Get-ChildItem "$Root\Core\*.ps1" |
Where-Object {

    $_.Name -notin @(
        "Loader.ps1",
        "PluginLoader.ps1"
    )

} |
Sort-Object Name |
ForEach-Object {

    Write-Host "Loading $($_.Name)"

    . $_.FullName

}



# ===============================
# PLUGINS
# ===============================

Write-Host ""

. "$Root\Core\PluginLoader.ps1"


Import-KhPlugins



# ===============================
# MODULES
# ===============================

Write-Host ""
Write-Host "Loading Modules..." -ForegroundColor Cyan



Get-ChildItem "$Root\Modules\*.ps1" |
Sort-Object Name |
ForEach-Object {

    Write-Host "Loading $($_.Name)"

    . $_.FullName

}




# ===============================
# COMMAND DISPATCHER
# ===============================


Write-Host ""
Write-Host "Loading Command Dispatcher..." -ForegroundColor Cyan


. "$Root\Core\kh.ps1"



Write-Host ""
Write-Host "KHAJA OS Loaded Successfully 🚀" -ForegroundColor Green
Write-Host ""