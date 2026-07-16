function Show-About {

    Clear-Host

    Write-Host ""
    Write-Host "╔══════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║                    KHAJA OS                         ║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""

    Write-Host "Version      : 5.2"
    Write-Host "Developer    : Khaja Shaik"
    Write-Host "Language     : PowerShell"
    Write-Host "Platform     : Windows Terminal"
    Write-Host "Repository   : https://github.com/khajashaik786786/KHAJA-OS"
    Write-Host ""

    Write-Host "Modules Installed"
    Write-Host "-----------------"

    Get-ChildItem "$PSScriptRoot\*.ps1" |
        Sort-Object Name |
        ForEach-Object {
            Write-Host ("✓ " + $_.BaseName)
        }

    Write-Host ""
}