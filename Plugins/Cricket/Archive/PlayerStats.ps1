function Show-PlayerStats{

Show-CricketTitle "PLAYER STATS"

$name=Read-Host "Player Name"

$url="https://api.cricapi.com/v1/players?apikey=2f08a5a3-d308-4f0c-9a04-d99ccf2317df&search=$name"

$json=Get-CricketJson $url

$json.data|Format-List

Wait-Key

}