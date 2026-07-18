function Test-Cricbuzz {

    Clear-Host

    Write-Host ""
    Write-Host "Testing Cricbuzz API..." -ForegroundColor Green
    Write-Host ""

    $data = Invoke-CricbuzzAPI "/mcenter/v1/40381/hscard"

    if($null -eq $data){

        Write-Host "API Failed" -ForegroundColor Red
        return

    }

    $data | Format-List *

}