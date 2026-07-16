function Search-Player {

    Show-CricketTitle "PLAYER SEARCH"

    $player = Read-Host "Enter Player Name"

    $url = "https://api.cricapi.com/v1/players?apikey=2f08a5a3-d308-4f0c-9a04-d99ccf2317df&search=$player"

    $json = Get-CricketJson $url

    if($null -eq $json){

        return

    }

    foreach($p in $json.data){

        Write-Host ""
        Write-Host "👤 $($p.name)" -ForegroundColor Yellow
        Write-Host "Country : $($p.country)"
        Write-Host "Role    : $($p.role)"
        Write-Host "Batting : $($p.battingStyle)"
        Write-Host "Bowling : $($p.bowlingStyle)"

        Show-Line

    }

    Wait-Key

}