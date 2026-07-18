function Show-CricbuzzLiveCentre {

    Clear-Host

    Write-Host ""
    Write-Host "===================================="
    Write-Host "       KHAJA LIVE CRICKET CENTRE"
    Write-Host "===================================="
    Write-Host ""


    $matches = Invoke-CricbuzzLive


    $count = 1


    foreach($m in $matches){

        $info = $m.matchInfo
        $score = $m.matchScore


        Write-Host "[$count] $($info.seriesName)"
        Write-Host "    Match ID : $($info.matchId)"
        Write-Host "    $($info.matchDesc)"
        Write-Host "    Format : $($info.matchFormat)"
        Write-Host "    Status: $($info.status)"
       if($info.state -eq "In Progress"){

    Write-Host "    🟢 LIVE"

}
elseif($info.state -eq "Complete"){

    Write-Host "    🔴 COMPLETE"

}
else{

    Write-Host "    ⚪ $($info.stateTitle)"

}

        Write-Host ""

if($score.team1Score){

    Write-Host "    Score:"

    if($score.team1Score.inngs1){

        $t1 = $score.team1Score.inngs1

       $team1 = $info.team1.teamName

Write-Host "    $team1 : $($t1.runs)/$($t1.wickets) ($($t1.overs))"

    }


    if($score.team2Score.inngs1){

        $t2 = $score.team2Score.inngs1

       $team2 = $info.team2.teamName

Write-Host "    $team2 : $($t2.runs)/$($t2.wickets) ($($t2.overs))"

    }

}
        $count++

    }

}