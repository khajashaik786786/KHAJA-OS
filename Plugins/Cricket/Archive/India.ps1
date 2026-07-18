function Show-IndiaMatches {

    Show-CricketTitle "INDIA MATCHES"

    Show-OK "Fetching India Matches..."

    $url = "https://api.cricapi.com/v1/currentMatches?apikey=2f08a5a3-d308-4f0c-9a04-d99ccf2317df&offset=0"

    $json = Get-CricketJson $url

    if($null -eq $json){
        return
    }

    $matches = $json.data | Where-Object {
        $_.name -match "India"
    }

    if($matches.Count -eq 0){

        Show-Warn "No India matches found."

        Wait-Key
        return
    }

    foreach($match in $matches){

        Write-Host ""
        Write-Host "════════════════════════════════════════════════════════════════════" -ForegroundColor DarkGray
        Write-Host "🇮🇳 $($match.name)" -ForegroundColor Yellow
        Write-Host "════════════════════════════════════════════════════════════════════" -ForegroundColor DarkGray

        Write-Host "🏆 Format : $($match.matchType)" -ForegroundColor Cyan
        Write-Host "📅 Date   : $($match.date)" -ForegroundColor White
        Write-Host "📍 Venue  : $($match.venue)" -ForegroundColor Green
        Write-Host "📢 Status : $($match.status)" -ForegroundColor Magenta

        Write-Host ""
        Write-Host "════════════ SCORECARD ════════════" -ForegroundColor Yellow

        foreach($score in $match.score){

            Write-Host ""
            Write-Host "🏏 $($score.inning)" -ForegroundColor Cyan
            Write-Host ("Runs  : {0}/{1}" -f $score.r,$score.w)
            Write-Host ("Overs : {0}" -f $score.o)

        }

        Write-Host ""
        Write-Host "════════════════════════════════════" -ForegroundColor Yellow
    }

    Wait-Key
}