function Draw-Title{

    param($Title)

    Clear-Host

    Write-Host ""

    Write-Host "╔══════════════════════════════════════════════════════╗" -ForegroundColor Cyan

    Write-Host ("║{0}║" -f $Title.PadLeft(27+$Title.Length/2).PadRight(54))

    Write-Host "╚══════════════════════════════════════════════════════╝" -ForegroundColor Cyan

    Write-Host ""

}