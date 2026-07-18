function Show-Points {

    Show-CricketTitle "POINTS TABLE"

    Show-OK "Loading Points Table..."

    $url = "https://api.cricapi.com/v1/series?apikey=2f08a5a3-d308-4f0c-9a04-d99ccf2317df"

    $json = Get-CricketJson $url

    if($null -eq $json){

        return

    }

    foreach($series in $json.data){

        Write-Host ""
        Write-Host "🏆 $($series.name)" -ForegroundColor Cyan

    }

    Wait-Key

}