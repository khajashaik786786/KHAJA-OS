function Show-Clock {

    $time = Get-Date -Format "dddd, dd MMM yyyy  HH:mm:ss"

    Write-Host ""
    Write-Host "🕒 $time" -ForegroundColor Cyan

}