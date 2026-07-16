function Update-TeluguNews {

    $Cache = Join-Path $PSScriptRoot "..\Cache"

    Write-Host "[Telugu News] Downloading..." -ForegroundColor Yellow

    try {

        Invoke-WebRequest `
        "https://news.google.com/rss/search?q=Telugu" `
        -OutFile "$Cache\telugu.xml"

        Write-Host "      ✓ Telugu News Updated" -ForegroundColor Green

    }
    catch {

        Write-Host "      ✗ Telugu News Failed" -ForegroundColor Red

    }

}

function Show-TeluguNews {

    $file = Join-Path $PSScriptRoot "..\Cache\telugu.xml"

    if(!(Test-Path $file)){
        Write-Host "Run: kh update first" -ForegroundColor Yellow
        return
    }

    [xml]$rss = Get-Content $file

    Write-Host ""
    Write-Host "=========== TELUGU NEWS ===========" -ForegroundColor Cyan
    Write-Host ""

    $rss.rss.channel.item |
    Select-Object -First 10 |
    ForEach-Object{

        Write-Host "📰 $($_.title)" -ForegroundColor Green
        Write-Host ""

    }

}