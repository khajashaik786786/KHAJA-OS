Clear-Host

Write-Host ""
Write-Host "████████████████████████████████████████████████████" -ForegroundColor DarkYellow
Write-Host "                 KHAJA " -ForegroundColor DarkYellow -NoNewline
Write-Host "SHAIK" -ForegroundColor Green
Write-Host "             CYBERPUNK TERMINAL" -ForegroundColor Cyan
Write-Host "████████████████████████████████████████████████████" -ForegroundColor DarkYellow
Write-Host ""

Write-Host ("👤 User     : " + $env:USERNAME) -ForegroundColor Yellow
Write-Host ("💻 Computer : " + $env:COMPUTERNAME) -ForegroundColor Green
Write-Host ("📅 Date     : " + (Get-Date -Format "dddd, dd MMMM yyyy")) -ForegroundColor White
Write-Host ("🕒 Time     : " + (Get-Date -Format "hh:mm:ss tt")) -ForegroundColor Magenta
Write-Host ""