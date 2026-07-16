function Show-Top {

    while ($true) {

        Clear-Host

        $cpu = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue

        $os = Get-CimInstance Win32_OperatingSystem
        $ram = (($os.TotalVisibleMemorySize - $os.FreePhysicalMemory) / $os.TotalVisibleMemorySize) * 100

        $disk = Get-CimInstance Win32_LogicalDisk -Filter "DeviceID='C:'"
        $diskUsed = (($disk.Size - $disk.FreeSpace) / $disk.Size) * 100

        $battery = Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue
        if ($battery) {
            $bat = $battery.EstimatedChargeRemaining
        } else {
            $bat = "N/A"
        }

        Write-Host ""
        Write-Host "╔════════════════════════════════════════════════════╗" -ForegroundColor Cyan
        Write-Host "║               KHAJA OS LIVE MONITOR               ║" -ForegroundColor Cyan
        Write-Host "╚════════════════════════════════════════════════════╝" -ForegroundColor Cyan
        Write-Host ""

        Write-Host ("CPU       {0:N1}%" -f $cpu)
        Write-Host ("RAM       {0:N1}%" -f $ram)
        Write-Host ("Disk      {0:N1}%" -f $diskUsed)
        Write-Host ("Battery   $bat%")
        Write-Host ""
        Write-Host ("Time      {0}" -f (Get-Date -Format "HH:mm:ss"))
        Write-Host ""
        Write-Host "Press Ctrl+C to exit..." -ForegroundColor Yellow

        Start-Sleep 1
    }
}