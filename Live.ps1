function Show-LiveMatches {

    Clear-Host

    Show-KhHeader "LIVE MATCHES"

    Start-KhAnimation @(
        "Connecting to Cricket Server",
        "Fetching Live Matches",
        "Preparing Scoreboard"
    )

    Write-Host ""
    Write-Host "🏏 LIVE MATCHES" -ForegroundColor Yellow
    Write-Host ""

    Write-Host "Real live data coming in next step..." -ForegroundColor Green
    Write-Host ""

    Show-KhFooter

}