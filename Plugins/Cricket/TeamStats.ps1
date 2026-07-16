function Show-TeamStats{

Show-CricketTitle "TEAM STATS"

$team=Read-Host "Team"

$url="https://api.cricapi.com/v1/players?apikey=2f08a5a3-d308-4f0c-9a04-d99ccf2317df&search=$team"

$json=Get-CricketJson $url

$json|ConvertTo-Json -Depth 5

Wait-Key

}