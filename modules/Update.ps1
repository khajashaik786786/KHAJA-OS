function Update-Khaja {

    $Cache = Join-Path $PSScriptRoot "..\Cache"

    Write-Host ""
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "      KHAJA OS UPDATE ENGINE"
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host ""

    # Weather
    Write-Host "[1/5] Updating Weather..." -ForegroundColor Yellow
    Update-Weather

    # Public IP
    Write-Host "[2/5] Updating Public IP..." -ForegroundColor Yellow
    Update-IP

    # News
    Write-Host "[3/5] Updating Semiconductor News..." -ForegroundColor Yellow
    Update-News

    # Jobs
    Write-Host "[4/5] Updating VLSI Jobs..." -ForegroundColor Yellow
    Update-Jobs
    Update-TeluguNews
    # Save Time
    Get-Date | Out-File "$Cache\lastupdate.txt"

    Write-Host ""
    Write-Host "===================================" -ForegroundColor Cyan
    Write-Host "      UPDATE COMPLETE"
    Write-Host "===================================" -ForegroundColor Cyan
}