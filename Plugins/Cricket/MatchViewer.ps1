function Show-CricbuzzMatch {

    param(
        [int]$MatchId
    )

    $match = Invoke-CricbuzzLive | Where-Object {
        $_.matchInfo.matchId -eq $MatchId
    }

    if (-not $match) {
        Write-Host "Match not found." -ForegroundColor Red
        return
    }

    $info  = $match.matchInfo
    $score = $match.matchScore

    Clear-Host

    Write-Host "===================================="
    Write-Host "          MATCH DETAILS"
    Write-Host "===================================="
    Write-Host ""

    Write-Host "Series : $($info.seriesName)"
    Write-Host "Match  : $($info.matchDesc)"
    Write-Host "Format : $($info.matchFormat)"
    Write-Host "Venue  : $($info.venueInfo.ground), $($info.venueInfo.city)"
    Write-Host ""

    Write-Host "$($info.team1.teamName) vs $($info.team2.teamName)"
    Write-Host ""

    Write-Host "Status : $($info.status)"
    Write-Host ""

    if ($score.team1Score.inngs1) {
        $t1 = $score.team1Score.inngs1
        Write-Host "$($info.team1.teamName) : $($t1.runs)/$($t1.wickets) ($($t1.overs))"
    }

    if ($score.team2Score.inngs1) {
        $t2 = $score.team2Score.inngs1
        Write-Host "$($info.team2.teamName) : $($t2.runs)/$($t2.wickets) ($($t2.overs))"
    }
}