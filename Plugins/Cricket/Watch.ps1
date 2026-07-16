function Start-WatchMode {

    while ($true) {

        Clear-Host

        Show-CricketTitle "WATCH MODE"

        Show-LiveMatches

        Write-Host ""
        Write-Host "Refreshing in 30 seconds..." -ForegroundColor Yellow
        Write-Host "Press CTRL+C to Exit"

        Start-Sleep 30

    }

}