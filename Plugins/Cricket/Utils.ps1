function Get-CricketJson {

    param($Url)

    try {

        Invoke-RestMethod $Url -TimeoutSec 20

    }
    catch {

        Show-Fail "Unable to connect to CricAPI."

        return $null

    }

}

function Show-CricketTitle {

    param($Title)

    Clear-Host

    Show-KhHeader $Title

}

function Wait-Key {

    Write-Host ""
    Read-Host "Press ENTER"

}

function Show-Line {

    Write-Host "══════════════════════════════════════════════════════" -ForegroundColor DarkGray

}