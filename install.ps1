Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "        KHAJA OS INSTALLER v1.0" -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

$source = "$PSScriptRoot\profile\Microsoft.PowerShell_profile.ps1"
$destinationFolder = "$HOME\Documents\PowerShell"

if (!(Test-Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder | Out-Null
}

Copy-Item $source "$destinationFolder\Microsoft.PowerShell_profile.ps1" -Force

Write-Host ""
Write-Host "Profile installed successfully!" -ForegroundColor Green
Write-Host ""