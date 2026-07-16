function Import-KhPlugins {

    $Root = Split-Path $PSScriptRoot -Parent
    $PluginRoot = Join-Path $Root "Plugins"

    Write-Host ""
    Write-Host "Loading Plugins..." -ForegroundColor Cyan

    if (!(Test-Path $PluginRoot)) {

        Write-Host "Plugins folder not found." -ForegroundColor Red
        return

    }

    Get-ChildItem $PluginRoot -Recurse -Filter *.ps1 |
    ForEach-Object {

        Write-Host "Loading $($_.Name)" -ForegroundColor Green

        . $_.FullName

    }

}