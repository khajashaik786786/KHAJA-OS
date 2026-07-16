function Show-Dashboard {

    Clear-Host

    Write-Host ""
    Write-Host "╔══════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║                    🚀 KHAJA OS DASHBOARD                    ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""

    Show-Clock
    Write-Host ""

    Show-System
    Write-Host ""

    Show-WeatherCenter
    Write-Host ""

    Show-NetworkCenter
    Write-Host ""

    Show-NewsCenter
    Write-Host ""

    Show-Jobs
}