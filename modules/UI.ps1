function Show-KhHeader {

    param([string]$Title)

    Clear-Host

    $width = 54
    $padding = [Math]::Floor(($width - $Title.Length) / 2)

    $line = (" " * $padding) + $Title
    $line = $line.PadRight($width)

    Write-Host ""
    Write-Host "╔══════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "║$line║" -ForegroundColor Cyan
    Write-Host "╚══════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
}

function Show-KhFooter {

    Write-Host ""
    Write-Host "══════════════════════════════════════════════════════" -ForegroundColor DarkGray
    Write-Host ""
}
function Show-KhBanner {

    param(
        [string]$Text,
        [ConsoleColor]$Color = "Yellow"
    )

    Write-Host ""
    Write-Host ("► " + $Text) -ForegroundColor $Color
    Write-Host ""
}
function Show-KhSection {

    param([string]$Title)

    Write-Host ""
    Write-Host "── $Title ─────────────────────────────────────────" -ForegroundColor DarkGray
}