function Show-Loading {

    param(
        [string]$Text,
        [int]$Delay = 400
    )

    Write-Host ""

    Write-Host "[    ] " -NoNewline
    Write-Host $Text -ForegroundColor DarkGray

    Start-Sleep -Milliseconds $Delay

    Write-Host "`r[ OK ] " -ForegroundColor Green -NoNewline
    Write-Host $Text -ForegroundColor White

    Start-Sleep -Milliseconds 150
}
function Start-KhAnimation {

    param(
        [string[]]$Steps
    )

    foreach($Step in $Steps){

        Show-Loading $Step 300
    }

    Write-Host ""
}
function Show-OK {

    param([string]$Text)

    Write-Host "[ " -NoNewline
    Write-Host "OK" -ForegroundColor Green -NoNewline
    Write-Host " ] $Text"
}

function Show-Warn {

    param([string]$Text)

    Write-Host "[ " -NoNewline
    Write-Host "WARN" -ForegroundColor Yellow -NoNewline
    Write-Host " ] $Text"
}

function Show-Fail {

    param([string]$Text)

    Write-Host "[ " -NoNewline
    Write-Host "FAIL" -ForegroundColor Red -NoNewline
    Write-Host " ] $Text"
}