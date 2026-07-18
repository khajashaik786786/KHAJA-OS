function Show-CricbuzzScorecard {

    param(
        [Parameter(Mandatory)]
        [int]$MatchId,

        [switch]$NoClear
    )

    $headers = @{
        "x-rapidapi-key"  = $Global:RapidApiKey
        "x-rapidapi-host" = $Global:RapidApiHost
    }

    $url = "https://cricbuzz-cricket.p.rapidapi.com/mcenter/v1/$MatchId/hscard"

    try {
        $json = Invoke-RestMethod `
            -Uri $url `
            -Headers $headers
    }
    catch {
        Show-Error "Unable to fetch scorecard."
        return
    }

    if (-not $NoClear) {
        Clear-Host
    }

    Show-CricketTitle "FULL SCORECARD"

    Write-Host ""
    Write-Host $json.status -ForegroundColor Yellow
    Write-Host ""

    foreach($innings in $json.scorecard){

        Write-Host "====================================================" -ForegroundColor DarkGray
        Write-Host "$($innings.batteamname)  $($innings.score)/$($innings.wickets) ($($innings.overs) overs)" -ForegroundColor Green
        Write-Host "====================================================" -ForegroundColor DarkGray
        Write-Host ""

        Write-Host "BATTING" -ForegroundColor Yellow
        "{0,-28}{1,5}{2,5}{3,8}" -f "Player","R","B","SR"

        foreach($bat in $innings.batsman){

            if($bat.balls -gt 0){

                "{0,-28}{1,5}{2,5}{3,8}" -f `
                    $bat.name,
                    $bat.runs,
                    $bat.balls,
                    $bat.strkrate

            }
        }

        Write-Host ""

        Write-Host "BOWLING" -ForegroundColor Yellow
        "{0,-28}{1,5}{2,5}{3,5}" -f "Bowler","O","W","R"

        foreach($bowler in $innings.bowler){

            "{0,-28}{1,5}{2,5}{3,5}" -f `
                $bowler.name,
                $bowler.overs,
                $bowler.wickets,
                $bowler.runs

        }

        Write-Host ""

        Write-Host "Extras   : $($innings.extras.total)"
        Write-Host "Run Rate : $($innings.runrate)"
        Write-Host ""

        Write-Host "Fall Of Wickets" -ForegroundColor Yellow

        $count = 1

        foreach($w in $innings.fow.fow){

            Write-Host ("{0} - {1}/{2} ({3})" -f `
                $w.batsmanname,
                $w.runs,
                $count,
                $w.overnbr)

            $count++
        }

        Write-Host ""
    }

    Write-Host "Status : $($json.status)" -ForegroundColor Cyan
}

function Show-Scorecard {

    Show-CricketTitle "FULL SCORECARD"

    $matches = Invoke-CricbuzzLive

    if(!$matches){
        Show-Error "No matches available."
        return
    }

    Write-Host ""

    for($i=0; $i -lt $matches.Count; $i++){

        $m = $matches[$i]

        Write-Host ("[{0}] {1} vs {2}" -f `
            ($i+1),
            $m.matchInfo.team1.teamName,
            $m.matchInfo.team2.teamName) -ForegroundColor Yellow

        Write-Host ("    {0}" -f $m.matchInfo.seriesName) -ForegroundColor DarkGray
        Write-Host ""
    }

    $choice = Read-Host "Select Match Number"

    if(($choice -as [int]) -lt 1 -or ($choice -as [int]) -gt $matches.Count){

        Show-Error "Invalid selection."
        return
    }

    $matchId = $matches[$choice-1].matchInfo.matchId

    Show-CricbuzzScorecard $matchId

    Wait-Key
}