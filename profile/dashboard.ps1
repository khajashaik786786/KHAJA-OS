if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
    fastfetch
}
else {
    Write-Host "Fastfetch is not installed or not in PATH." -ForegroundColor Yellow
}