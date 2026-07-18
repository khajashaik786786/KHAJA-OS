# =====================================
# KHAJA OS v5 MAIN LOADER
# =====================================


$Root = Split-Path $PSScriptRoot -Parent



# =====================================
# LOAD CORE
# =====================================

Write-Host ""
Write-Host "Loading Core..." -ForegroundColor Cyan


Get-ChildItem "$Root\Core\*.ps1" |
Where-Object {

    $_.Name -notin @(
        "Loader.ps1",
        "PluginLoader.ps1",
        "kh.ps1"
    )

} |
Sort-Object Name |
ForEach-Object {

    Write-Host "Loading $($_.Name)"

    . $_.FullName

}



# =====================================
# LOAD PLUGIN SYSTEM
# =====================================


Write-Host ""
Write-Host "Loading Plugin System..." -ForegroundColor Cyan


. "$Root\Core\PluginLoader.ps1"



# =====================================
# LOAD PLUGINS
# =====================================


Import-KhPlugins



# =====================================
# LOAD MODULES
# =====================================


Write-Host ""
Write-Host "Loading Modules..." -ForegroundColor Cyan



if(Test-Path "$Root\Modules"){


    Get-ChildItem "$Root\Modules\*.ps1" |
    Sort-Object Name |
    ForEach-Object {


        Write-Host "Loading $($_.Name)"

        . $_.FullName


    }

}



# =====================================
# LOAD COMMAND DISPATCHER LAST
# =====================================


Write-Host ""
Write-Host "Loading Command Dispatcher..." -ForegroundColor Cyan


. "$Root\Core\kh.ps1"



# =====================================
# COMPLETE
# =====================================


Write-Host ""
Write-Host "KHAJA OS Loaded Successfully 🚀" -ForegroundColor Green
Write-Host ""
