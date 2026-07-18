function Watch-Scorecard {

    param(
        [Parameter(Mandatory)]
        [int]$MatchId,

        [int]$Refresh = 10
    )

    while($true){

        Show-CricbuzzScorecard $MatchId

        Write-Host ""
        Write-Host "Refreshing in $Refresh seconds... (Ctrl+C to stop)" -ForegroundColor Yellow

        Start-Sleep $Refresh
    }
}