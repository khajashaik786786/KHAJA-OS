function Show-TodayMatches {

    Show-CricketTitle "TODAY'S MATCHES"

    Show-OK "Fetching today's fixtures..."

    $url = "https://api.cricapi.com/v1/currentMatches?apikey=2f08a5a3-d308-4f0c-9a04-d99ccf2317df&offset=0"

    $json = Get-CricketJson $url

    if($null -eq $json){
        return
    }

    if($json.data.Count -eq 0){

        Show-Warn "No matches found."
        Wait-Key
        return

    }

    foreach($match in $json.data){

        Write-Host ""

        Write-Host "🏏 $($match.name)" -ForegroundColor Yellow

        Write-Host "🏆 Format : $($match.matchType)"

        Write-Host "📍 Venue  : $($match.venue)"

        Write-Host "📢 Status : $($match.status)" -ForegroundColor Green

        Show-Line

    }

    Wait-Key

}