function Update-News {

    $Cache = Join-Path $PSScriptRoot "..\Cache"

    Write-Host "[News] Downloading Semiconductor News..." -ForegroundColor Yellow

    try {
        Invoke-WebRequest `
            "https://news.google.com/rss/search?q=semiconductor" `
            -OutFile "$Cache\news.xml"

        Write-Host "✓ News Updated" -ForegroundColor Green
    }
    catch {
        Write-Host "✗ News Failed" -ForegroundColor Red
        Write-Host $_.Exception.Message
    }
}