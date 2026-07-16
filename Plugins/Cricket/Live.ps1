function Show-LiveMatches {

    Clear-Host

    Show-KhHeader "LIVE CRICKET"

    Start-KhAnimation @(
        "Connecting to CricAPI",
        "Fetching Live Matches",
        "Preparing Live Dashboard"
    )

    $url = "https://api.cricapi.com/v1/currentMatches?apikey=$Global:CricketApiKey&offset=0"

    $json = Get-CricketJson $url

    if($null -eq $json){

        Show-Fail "Unable to connect to CricAPI."
        return

    }

    if($json.status -ne "success"){

        Show-Fail $json.message
        return

    }

    $liveMatches = $json.data | Where-Object{

        $_.status -match "Live|Day|Session|Need|need|Requires|requires|Tea|Lunch|Stumps|Break"

    }

    if(!$liveMatches){

        Show-Warn "No Live Matches Found"
        Write-Host ""
        Write-Host "Showing Recent Matches..." -ForegroundColor DarkYellow
        Write-Host ""

        $liveMatches = $json.data | Select-Object -First 5

    }

    foreach($match in $liveMatches){

        Write-Host ""
        Write-Host "╔══════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
        Write-Host "║                           🏏 LIVE MATCH                            ║" -ForegroundColor Cyan
        Write-Host "╚══════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan

        Write-Host ""

        Write-Host $match.name -ForegroundColor Yellow

        Write-Host ""

        $format=$match.matchType

        if([string]::IsNullOrWhiteSpace($format)){

            if($match.name -match "Test"){
                $format="Test"
            }
            elseif($match.name -match "ODI"){
                $format="ODI"
            }
            elseif($match.name -match "T20"){
                $format="T20"
            }
            elseif($match.name -match "IPL"){
                $format="IPL"
            }
            else{
                $format="Unknown"
            }

        }

        Write-Host "🏆 Format :" -NoNewline
        Write-Host " $format" -ForegroundColor Green

        Write-Host "📍 Venue  :" -NoNewline
        Write-Host " $($match.venue)" -ForegroundColor White

        Write-Host "📢 Status :" -NoNewline
        Write-Host " $($match.status)" -ForegroundColor Magenta

        Write-Host ""
        Write-Host "══════════════ SCORECARD ══════════════" -ForegroundColor Cyan

        if($match.score){

            foreach($inning in $match.score){

                $team=$inning.inning

                $team=$team -replace ","," vs "
                $team=$team -replace "Inning 1",""
                $team=$team -replace "Inning 2",""
                $team=$team -replace "Innings",""
                $team=$team.Trim()

                Write-Host ""

                Write-Host "🏏 $team" -ForegroundColor Yellow

                Write-Host ("Runs  : {0}/{1}" -f $inning.r,$inning.w) -ForegroundColor Green

                Write-Host ("Overs : {0}" -f $inning.o) -ForegroundColor Cyan

            }

        }
        else{

            Show-Warn "Score not available."

        }

        Write-Host ""
        Write-Host "═══════════════════════════════════════" -ForegroundColor Cyan
        Write-Host ""

    }

    Show-KhFooter

}