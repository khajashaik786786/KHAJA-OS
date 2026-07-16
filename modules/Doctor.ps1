function Show-Doctor {

    Clear-Host

    Write-Host ""
    Write-Host "╔══════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║              KHAJA OS DOCTOR                ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""

    function Test-App($Name) {

        if (Get-Command $Name -ErrorAction SilentlyContinue) {
            Write-Host ("{0,-20}" -f $Name) -NoNewline
            Write-Host "✓ Installed" -ForegroundColor Green
        }
        else {
            Write-Host ("{0,-20}" -f $Name) -NoNewline
            Write-Host "✗ Missing" -ForegroundColor Red
        }
    }

    Test-App git
    Test-App code
    Test-App winget
    Test-App pwsh

    Write-Host ""

    Write-Host "Internet            " -NoNewline

    if (Test-Connection google.com -Count 1 -Quiet) {
        Write-Host "✓ Connected" -ForegroundColor Green
    }
    else {
        Write-Host "✗ Offline" -ForegroundColor Red
    }

    Write-Host ""
}