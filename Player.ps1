function Search-Player {

    param(
        [string]$Player
    )

    if([string]::IsNullOrWhiteSpace($Player)){

        $Player=Read-Host "Enter Player Name"

    }

    Show-KhHeader "PLAYER SEARCH"

    Write-Host ""
    Write-Host "Searching for $Player..." -ForegroundColor Yellow
    Write-Host ""

    Show-KhFooter

}