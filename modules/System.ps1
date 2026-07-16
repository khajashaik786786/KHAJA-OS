function Show-System {

    $cpu = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
    $os = Get-CimInstance Win32_OperatingSystem

    $total = [math]::Round($os.TotalVisibleMemorySize / 1MB,2)
    $free  = [math]::Round($os.FreePhysicalMemory / 1MB,2)
    $used  = [math]::Round($total - $free,2)

    $battery = Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue

    Write-Host "============= SYSTEM =============" -ForegroundColor Cyan
    Write-Host ("CPU Usage : {0:N1}%" -f $cpu)
    Write-Host ("RAM Usage : {0} GB / {1} GB" -f $used,$total)

    if($battery){
        Write-Host ("Battery  : {0}%" -f $battery.EstimatedChargeRemaining)
    }
    else{
        Write-Host "Battery  : Desktop"
    }

}