function Show-MatchCard($match){

    Clear-Host

    Show-CricketTitle "MATCH DETAILS"

    Write-Host ""

    Write-Host $match.name -ForegroundColor Yellow
    Write-Host ""

    Write-Host "🏆 Format : $($match.matchType)"
    Write-Host "📍 Venue  : $($match.venue)"
    Write-Host "📢 Status : $($match.status)"

    Write-Host ""
    Write-Host "════════════ SCORECARD ════════════"

    foreach($score in $match.score){

        Write-Host ""

        Write-Host "🏏 $($score.inning)" -ForegroundColor Cyan
        Write-Host "Runs  : $($score.r)/$($score.w)"
        Write-Host "Overs : $($score.o)"

    }

    Write-Host ""
    Wait-Key

}