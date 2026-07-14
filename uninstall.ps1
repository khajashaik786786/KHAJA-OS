$profileFile = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"

if (Test-Path $profileFile) {
    Remove-Item $profileFile -Force
    Write-Host "Profile removed." -ForegroundColor Green
}
else {
    Write-Host "Profile not found." -ForegroundColor Yellow
}