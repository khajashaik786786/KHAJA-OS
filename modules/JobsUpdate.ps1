function Update-Jobs {

    $Cache = Join-Path $PSScriptRoot "..\Cache"

    Write-Host "[Jobs] Downloading VLSI Jobs..." -ForegroundColor Yellow

    try {

        Invoke-WebRequest `
        "https://news.google.com/rss/search?q=VLSI+jobs" `
        -OutFile "$Cache\jobs.xml"

        Write-Host "       ✓ Jobs Updated" -ForegroundColor Green

    }
    catch {

        Write-Host "       ✗ Jobs Failed" -ForegroundColor Red

    }

}