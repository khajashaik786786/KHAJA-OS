function Search-Match{

Show-CricketTitle "SEARCH MATCH"

$name=Read-Host "Team"

$url="https://api.cricapi.com/v1/currentMatches?apikey=2f08a5a3-d308-4f0c-9a04-d99ccf2317df&offset=0"

$json=Get-CricketJson $url

foreach($m in $json.data){

if($m.name-match$name){

Write-Host ""

Write-Host $m.name -ForegroundColor Yellow

Write-Host $m.status

Write-Host $m.venue

}

}

Wait-Key

}