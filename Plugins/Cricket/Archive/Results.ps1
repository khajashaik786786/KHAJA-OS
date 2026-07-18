function Show-Results{

Show-CricketTitle "RECENT RESULTS"

$url="https://api.cricapi.com/v1/currentMatches?apikey=2f08a5a3-d308-4f0c-9a04-d99ccf2317df&offset=0"

$json=Get-CricketJson $url

foreach($m in $json.data){

if($m.status-notmatch"Live"){

Write-Host ""

Write-Host $m.name -ForegroundColor Green

Write-Host $m.status

}

}

Wait-Key

}