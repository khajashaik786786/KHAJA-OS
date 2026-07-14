$frames = @(
"[□□□□□□□□□□] 0%",
"[■□□□□□□□□□] 10%",
"[■■□□□□□□□□] 20%",
"[■■■□□□□□□□] 30%",
"[■■■■□□□□□□] 40%",
"[■■■■■□□□□□] 50%",
"[■■■■■■□□□□] 60%",
"[■■■■■■■□□□] 70%",
"[■■■■■■■■□□] 80%",
"[■■■■■■■■■□] 90%",
"[■■■■■■■■■■] 100%"
)

foreach ($frame in $frames) {
    Write-Host "`rLoading KHAJA OS $frame" -ForegroundColor Cyan -NoNewline
    Start-Sleep -Milliseconds 70
}

Write-Host ""
Write-Host "✔ Startup Complete" -ForegroundColor Green
Write-Host ""