function Show-LiveMatches {

    Clear-Host

    Show-CricketTitle "🔴 LIVE MATCHES"

    Write-Host ""
    Write-Host "[ OK ] Reading Match Cache..." -ForegroundColor Green
    if($Global:AllMatches.Count -eq 0){

    Update-MatchCache

}
else{

    Refresh-MatchCache

}
    Write-Host ""

    $live = Get-LiveMatches

    if($live.Count -eq 0){

        Write-Host "No Live Matches." -ForegroundColor Yellow
        Wait-Key
        return

    }

    $i = 1

    foreach($match in $live){

        Write-Host "[$i] $($match.name)" -ForegroundColor Cyan

        Write-Host "     📍 $($match.venue)"
        Write-Host "     📢 $($match.status)"

        Write-Host ""

        foreach($score in $match.score){

            $team = $score.inning

            $team = $team -replace " Inning 1",""
            $team = $team -replace " Inning 2",""

            "{0,-28} {1}/{2} ({3})" -f $team,$score.r,$score.w,$score.o

        }

        Write-Host ""
        Write-Host "────────────────────────────────────────────────────────────"

        $i++

    }

    Write-Host ""

    $choice = Read-Host "Select Match Number (0 Exit)"

    if($choice -eq 0){

        return

    }

    if(($choice -ge 1) -and ($choice -le $live.Count)){

        Show-MatchCard $live[$choice-1]

    }

}