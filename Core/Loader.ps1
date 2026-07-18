# ===============================
# KHAJA OS v5 Loader
# ===============================

$Root = Split-Path $PSScriptRoot -Parent


# -------------------------------
# Load Core
# -------------------------------

Write-Host ""
Write-Host "Loading Core..." -ForegroundColor Cyan

Get-ChildItem "$Root\Core\*.ps1" |
Where-Object { $_.Name -ne "Loader.ps1" } |
Sort-Object Name |
ForEach-Object {

    Write-Host "Loading $($_.Name)"
    . $_.FullName

}


# -------------------------------
# Load Modules
# -------------------------------

Write-Host ""
Write-Host "Loading Modules..." -ForegroundColor Cyan

Get-ChildItem "$Root\Modules\*.ps1" |
Sort-Object Name |
ForEach-Object {

    Write-Host "Loading $($_.Name)"
    . $_.FullName

}


# -------------------------------
# Load Plugins
# -------------------------------

Write-Host ""
Write-Host "Loading Plugins..." -ForegroundColor Cyan


# Auto load all plugins
. Import-KhPlugins


# Cricket additional modules
$CricketPath = "$Root\Plugins\Cricket"


if(Test-Path "$CricketPath\LiveCentre.ps1") {

    Write-Host "Loading LiveCentre.ps1"
    . "$CricketPath\LiveCentre.ps1"

}


if(Test-Path "$CricketPath\WatchLive.ps1") {

    Write-Host "Loading WatchLive.ps1"
    . "$CricketPath\WatchLive.ps1"

}

if(Test-Path "Plugins\Cricket\MatchViewer.ps1") {
    Write-Host "Loading MatchViewer.ps1"
    . Plugins\Cricket\MatchViewer.ps1
}


# -------------------------------
# Load Command Dispatcher Last
# -------------------------------

Write-Host ""
Write-Host "Loading Command Dispatcher..." -ForegroundColor Cyan

. "$Root\Core\kh.ps1"


Write-Host ""
Write-Host "KHAJA OS Loaded Successfully 🚀" -ForegroundColor Green
Write-Host ""