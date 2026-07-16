function Show-UpcomingMatches {

    Show-CricketTitle "UPCOMING MATCHES"

    Show-OK "Fetching upcoming fixtures..."

    $url="https://api.cricapi.com/v1/matches?apikey=2f08a5a3-d308-4f0c-9a04-d99ccf2317df&offset=0"

    $json=Get-CricketJson $url

    if($null -eq $json){

        return

    }

    foreach($match in $json.data){

        if($match.status -match "Starts"){

            Write-Host ""

            Write-Host "🏏 $($match.name)" -ForegroundColor Yellow

            Write-Host "📅 $($match.date)"

            Write-Host "📍 $($match.venue)"

            Write-Host "🏆 $($match.matchType)"

            Show-Line

        }

    }

    Wait-Key

}