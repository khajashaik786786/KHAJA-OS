function Show-Panel {

    param(

        [string]$Title,

        [scriptblock]$Content

    )

    Write-Host ""

    Write-Host "╔══════════════════════════════════════════════════════╗" -ForegroundColor Cyan

    Write-Host ("║ {0,-52}║" -f $Title) -ForegroundColor Cyan

    Write-Host "╠══════════════════════════════════════════════════════╣" -ForegroundColor Cyan

    & $Content

    Write-Host "╚══════════════════════════════════════════════════════╝" -ForegroundColor Cyan

}