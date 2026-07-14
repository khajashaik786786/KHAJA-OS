# CPU Usage
$cpu = Get-Counter '\Processor(_Total)\% Processor Time'
$cpuUsage = [math]::Round($cpu.CounterSamples.CookedValue)

# RAM
$os = Get-CimInstance Win32_OperatingSystem

$total = [math]::Round($os.TotalVisibleMemorySize/1MB,1)
$free = [math]::Round($os.FreePhysicalMemory/1MB,1)
$used = [math]::Round($total-$free,1)

# Disk

$disk = Get-PSDrive C

$totalDisk = [math]::Round(($disk.Used+$disk.Free)/1GB,1)
$freeDisk = [math]::Round($disk.Free/1GB,1)

Write-Host ""
Write-Host "================ SYSTEM ==================" -ForegroundColor Cyan

Write-Host ("CPU Usage : " + $cpuUsage + "%") -ForegroundColor Yellow

Write-Host ("RAM       : $used GB / $total GB") -ForegroundColor Green

Write-Host ("Disk Free : $freeDisk GB / $totalDisk GB") -ForegroundColor Magenta

Write-Host "==========================================" -ForegroundColor Cyan