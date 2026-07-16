function Show-Jobs {

    $file = Join-Path $PSScriptRoot "..\Cache\jobs.xml"

    if(!(Test-Path $file)){
        Write-Host "Run: kh update" -ForegroundColor Yellow
        return
    }

    [xml]$rss = Get-Content $file

    Write-Host ""
    Write-Host "============= VLSI JOBS =============" -ForegroundColor Cyan

    $rss.rss.channel.item |
        Select-Object -First 5 |
        ForEach-Object{

            Write-Host "💼 $($_.title)" -ForegroundColor Green

        }

}
