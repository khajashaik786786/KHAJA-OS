function Show-NewsCenter {

    $file = Join-Path $PSScriptRoot "..\Cache\news.xml"

    if (!(Test-Path $file)) {
        Write-Host "Run: kh update first" -ForegroundColor Yellow
        return
    }

    [xml]$rss = Get-Content $file

    Write-Host ""
    Write-Host "========== SEMICONDUCTOR NEWS ==========" -ForegroundColor Cyan
    Write-Host ""

    $rss.rss.channel.item |
        Select-Object -First 10 |
        ForEach-Object {

            Write-Host "▶ $($_.title)" -ForegroundColor Green
            Write-Host ""

        }

}