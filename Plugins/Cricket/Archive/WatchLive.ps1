function Watch-CricbuzzLive {

    while($true){

        Clear-Host

        Show-CricbuzzLiveCentre

        for($i=30;$i -gt 0;$i--){

    Write-Host "`rRefreshing in $i seconds..." -NoNewline

    Start-Sleep 1

}

Write-Host ""

    }

}