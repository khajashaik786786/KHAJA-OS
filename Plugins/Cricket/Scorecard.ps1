function Show-Scorecard {

    Show-CricketTitle "FULL SCORECARD"

    Show-OK "Fetching Match Scorecards..."

    $url = "https://api.cricapi.com/v1/currentMatches?apikey=$Global:CricketApiKey&offset=0"

    $json = Get-CricketJson $url

    if($null -eq $json){
        return
    }

    foreach($match in $json.data){

        Write-Host ""
        Write-Host "════════════════════════════════════════════════════════════════════" -ForegroundColor DarkGray
        Write-Host "🏏 $($match.name)" -ForegroundColor Yellow
        Write-Host "════════════════════════════════════════════════════════════════════" -ForegroundColor DarkGray

        Write-Host "🏆 Format : $($match.matchType)" -ForegroundColor Cyan
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