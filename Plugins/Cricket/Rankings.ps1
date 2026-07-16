function Show-Rankings {

    Show-CricketTitle "ICC RANKINGS"

    Show-OK "Fetching ICC Rankings..."

    $url = "https://api.cricapi.com/v1/rankings?apikey=2f08a5a3-d308-4f0c-9a04-d99ccf2317df"

    $json = Get-CricketJson $url

    if ($null -eq $json) {
        Wait-Key
        return
    }

    if (-not $json.data) {
        Show-Warn "No ranking data returned by the API."
        $json | ConvertTo-Json -Depth 5
        Wait-Key
        return
    }

    foreach ($type in $json.data) {

        Write-Host ""
        Write-Host "🏆 $($type.rankType)" -ForegroundColor Yellow

        foreach ($team in $type.rank) {

            "{0,-3} {1,-30} {2,6}" -f $team.rank, $team.name, $team.rating

        }

        Show-Line

    }

    Wait-Key
}