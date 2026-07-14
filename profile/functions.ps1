#############################################################
# KHAJA OS v4.0
# functions.ps1
# PART 1 / 5
#############################################################

# ==========================================================
# GLOBAL SETTINGS
# ==========================================================

$Global:KhajaVersion = "4.0"
$Global:KhajaBuild   = "Ultimate"
$Global:BarLength    = 32

# ==========================================================
# COLORS
# ==========================================================

$Global:CLR = @{
    Cyan   = "Cyan"
    Green  = "Green"
    White  = "White"
    Yellow = "Yellow"
    Orange = "DarkYellow"
}

# ==========================================================
# WRITE COLORED TEXT
# ==========================================================

function Write-KColor {

    param(
        [string]$Text,
        [string]$Color = $Global:CLR.White,
        [switch]$NoNewLine
    )

    if ($NoNewLine) {
        Write-Host $Text -ForegroundColor $Color -NoNewline
    }
    else {
        Write-Host $Text -ForegroundColor $Color
    }

}

# ==========================================================
# HORIZONTAL LINE
# ==========================================================

function Draw-Line {

    param(
        [string]$Color = $Global:CLR.Gray,
        [int]$Length = 70,
        [char]$Char = "─"
    )

    Write-Host (($Char.ToString()) * $Length) -ForegroundColor $Color

}

# ==========================================================
# CENTER TEXT
# ==========================================================

function Write-Center {

    param(
        [string]$Text,
        [string]$Color = $Global:CLR.White
    )

    $Width = $Host.UI.RawUI.WindowSize.Width

    if ($Width -lt $Text.Length) {
        Write-Host $Text -ForegroundColor $Color
        return
    }

    $Pad = [Math]::Floor(($Width - $Text.Length) / 2)

    Write-Host (" " * $Pad + $Text) -ForegroundColor $Color

}

# ==========================================================
# RGB RAINBOW TEXT
# ==========================================================

function Write-RGB {

    param(
        [string]$Text
    )

    $Colors = @(
        "Red",
        "Yellow",
        "Green",
        "Cyan",
        "Blue",
        "Magenta"
    )

    $i = 0

    foreach ($c in $Text.ToCharArray()) {

        Write-Host $c -ForegroundColor $Colors[$i] -NoNewline

        $i++

        if ($i -ge $Colors.Count) {
            $i = 0
        }

    }

    Write-Host

}

# ==========================================================
# DRAW PROGRESS BAR
# ==========================================================

function Draw-Bar {

    param(
        [string]$Label,
        [int]$Percent
    )

    if ($Percent -lt 0) {
        $Percent = 0
    }

    if ($Percent -gt 100) {
        $Percent = 100
    }

    $Filled = [Math]::Round(($Percent / 100) * $Global:BarLength)

    $Empty = $Global:BarLength - $Filled

    $Bar = ("█" * $Filled) + ("░" * $Empty)

    if ($Percent -lt 40) {
        $Color = $Global:CLR.Green
    }
    elseif ($Percent -lt 70) {
        $Color = $Global:CLR.Yellow
    }
    elseif ($Percent -lt 90) {
        $Color = $Global:CLR.Orange
    }
    else {
        $Color = $Global:CLR.Red
    }

    Write-Host ("{0,-12}" -f $Label) -ForegroundColor $Global:CLR.Cyan -NoNewline
    Write-Host " $Bar " -ForegroundColor $Color -NoNewline
    Write-Host ("{0,3}%" -f $Percent) -ForegroundColor $Global:CLR.White

}

# ==========================================================
# SPINNER
# ==========================================================

function Show-Spinner {

    param(
        [int]$Seconds = 3,
        [string]$Message = "Loading"
    )

    $Chars = @("|","/","-","\")

    $End = (Get-Date).AddSeconds($Seconds)

    $i = 0

    while ((Get-Date) -lt $End) {

        Write-Host "`r$Message $($Chars[$i])" -ForegroundColor Cyan -NoNewline

        Start-Sleep -Milliseconds 120

        $i++

        if ($i -ge $Chars.Count) {
            $i = 0
        }

    }

    Write-Host "`r$Message Done.     " -ForegroundColor Green

}

# ==========================================================
# RGB LOADING BAR
# ==========================================================

function Start-RGBLoading {

    param(
        [string]$Title = "Initializing KHAJA OS",
        [int]$Delay = 18
    )

    Write-Host
    Write-Center $Title $Global:CLR.Cyan
    Write-Host

    for ($i = 0; $i -le 100; $i++) {

        Draw-Bar "BOOT" $i

        Start-Sleep -Milliseconds $Delay

        if ($i -lt 100) {
            [Console]::SetCursorPosition(0, [Console]::CursorTop - 1)
        }

    }

    Write-Host

}

# ==========================================================
# CLEAR SCREEN
# ==========================================================

function clsx {

    Clear-Host

}

Set-Alias clsx clsx
#############################################################
# KHAJA OS v4.0
# functions.ps1
# PART 2 / 5
#############################################################

# ==========================================================
# CPU INFORMATION
# ==========================================================

function Get-KCPU {

    try {

        $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1

        [PSCustomObject]@{
            Name  = $cpu.Name.Trim()
            Cores = $cpu.NumberOfCores
            Threads = $cpu.NumberOfLogicalProcessors
            Load  = [int]$cpu.LoadPercentage
        }

    }
    catch {

        [PSCustomObject]@{
            Name    = "Unknown"
            Cores   = 0
            Threads = 0
            Load    = 0
        }

    }

}

# ==========================================================
# MEMORY INFORMATION
# ==========================================================

function Get-KMemory {

    try {

        $os = Get-CimInstance Win32_OperatingSystem

        $total = [math]::Round($os.TotalVisibleMemorySize / 1MB,2)
        $free  = [math]::Round($os.FreePhysicalMemory / 1MB,2)
        $used  = [math]::Round($total - $free,2)

        $percent = [int](($used / $total) * 100)

        [PSCustomObject]@{
            Total   = $total
            Used    = $used
            Free    = $free
            Percent = $percent
        }

    }
    catch {

        [PSCustomObject]@{
            Total   = 0
            Used    = 0
            Free    = 0
            Percent = 0
        }

    }

}

# ==========================================================
# DISK INFORMATION
# ==========================================================

function Get-KDisk {

    try {

        Get-CimInstance Win32_LogicalDisk |
        Where-Object { $_.DriveType -eq 3 } |
        ForEach-Object {

            $total = [math]::Round($_.Size/1GB,2)
            $free  = [math]::Round($_.FreeSpace/1GB,2)
            $used  = [math]::Round($total-$free,2)

            [PSCustomObject]@{

                Drive   = $_.DeviceID
                Total   = $total
                Used    = $used
                Free    = $free
                Percent = [int](($used/$total)*100)

            }

        }

    }
    catch {

        $null

    }

}

# ==========================================================
# GPU INFORMATION
# ==========================================================

function Get-KGPU {

    try {

        Get-CimInstance Win32_VideoController |
        Select-Object Name,
                      DriverVersion,
                      VideoProcessor,
                      AdapterRAM

    }
    catch {

        $null

    }

}

# ==========================================================
# BATTERY INFORMATION
# ==========================================================

function Get-KBattery {

    try {

        $battery = Get-CimInstance Win32_Battery

        if ($battery) {

            [PSCustomObject]@{

                Percent = $battery.EstimatedChargeRemaining
                Status  = $battery.BatteryStatus

            }

        }
        else {

            [PSCustomObject]@{

                Percent = "N/A"
                Status  = "Desktop"

            }

        }

    }
    catch {

        [PSCustomObject]@{

            Percent = "N/A"
            Status  = "Unknown"

        }

    }

}

# ==========================================================
# NETWORK INFORMATION
# ==========================================================

function Get-KNetwork {

    try {

        $adapter = Get-NetAdapter |
                   Where-Object Status -eq "Up" |
                   Select-Object -First 1

        $ip = (Get-NetIPAddress `
                -AddressFamily IPv4 `
                -InterfaceIndex $adapter.ifIndex |
                Where-Object {$_.IPAddress -notlike "169.*"} |
                Select-Object -First 1).IPAddress

        [PSCustomObject]@{

            Adapter = $adapter.Name
            Speed   = $adapter.LinkSpeed
            IP      = $ip

        }

    }
    catch {

        [PSCustomObject]@{

            Adapter = "Disconnected"
            Speed   = "-"
            IP      = "-"

        }

    }

}

# ==========================================================
# INTERNET TEST
# ==========================================================

function Test-KInternet {

    try {

        if (Test-Connection 8.8.8.8 -Quiet -Count 1) {

            Write-Host " Internet : ONLINE" -ForegroundColor Green

        }
        else {

            Write-Host " Internet : OFFLINE" -ForegroundColor Red

        }

    }
    catch {

        Write-Host " Internet : OFFLINE" -ForegroundColor Red

    }

}

# ==========================================================
# SYSTEM UPTIME
# ==========================================================

function Get-KUptime {

    $boot = (Get-CimInstance Win32_OperatingSystem).LastBootUpTime

    $span = (Get-Date) - $boot

    "{0}d {1}h {2}m" -f $span.Days,
                       $span.Hours,
                       $span.Minutes

}

# ==========================================================
# LIVE DIGITAL CLOCK
# ==========================================================

function clock {

    while ($true) {

        Clear-Host

        Write-Host
        Write-Center "KHAJA DIGITAL CLOCK" Cyan
        Draw-Line

        Write-Host

        Write-Center (Get-Date -Format "HH:mm:ss") Green

        Write-Host

        Write-Center (Get-Date -Format "dddd, dd MMMM yyyy") Yellow

        Start-Sleep -Seconds 1

    }

}

# ==========================================================
# QUICK SYSTEM SUMMARY
# ==========================================================

function sys {

    $cpu = Get-KCPU
    $ram = Get-KMemory
    $bat = Get-KBattery

    Draw-Line Cyan

    Write-Host " CPU      : $($cpu.Name)" -ForegroundColor White
    Write-Host " CORES    : $($cpu.Cores)" -ForegroundColor White
    Write-Host " THREADS  : $($cpu.Threads)" -ForegroundColor White

    Draw-Bar "CPU" $cpu.Load
    Draw-Bar "RAM" $ram.Percent

    Write-Host " Battery  : $($bat.Percent)%" -ForegroundColor White
    Write-Host " Uptime   : $(Get-KUptime)" -ForegroundColor White

    Draw-Line Cyan

}

# ==========================================================
# END OF PART 2
# ==========================================================
#############################################################
# KHAJA OS v4.0
# functions.ps1
# PART 3 / 5
#############################################################

# ==========================================================
# WEATHER
# ==========================================================

function weather {

    param(
        [string]$City = ""
    )

    try {

        if ([string]::IsNullOrWhiteSpace($City)) {
            Invoke-RestMethod "https://wttr.in/?format=3"
        }
        else {
            Invoke-RestMethod "https://wttr.in/$City`?format=3"
        }

    }
    catch {

        Write-Host "Unable to fetch weather." -ForegroundColor Red

    }

}

# ==========================================================
# PUBLIC IP
# ==========================================================

function publicip {

    try {

        (Invoke-RestMethod "https://api.ipify.org").ToString()

    }
    catch {

        Write-Host "Unavailable" -ForegroundColor Red

    }

}

# ==========================================================
# LOCAL IP
# ==========================================================

function localip {

    try {

        Get-NetIPAddress `
            -AddressFamily IPv4 |
        Where-Object {
            $_.IPAddress -notlike "169.*" -and
            $_.InterfaceAlias -notmatch "Loopback"
        } |
        Select-Object InterfaceAlias,IPAddress

    }
    catch {

        Write-Host "Unavailable" -ForegroundColor Red

    }

}

# ==========================================================
# INTERNET SPEED TEST
# ==========================================================

function speedtest {

    if (Get-Command speedtest -ErrorAction SilentlyContinue) {

        speedtest

    }
    elseif (Get-Command speedtest-cli -ErrorAction SilentlyContinue) {

        speedtest-cli

    }
    else {

        Write-Host ""
        Write-Host "Ookla Speedtest CLI is not installed." -ForegroundColor Yellow
        Write-Host "Install using:" -ForegroundColor Cyan
        Write-Host "winget install Ookla.Speedtest.CLI" -ForegroundColor Green

    }

}

# ==========================================================
# PING TEST
# ==========================================================

function pingtest {

    param(
        [string]$Host = "8.8.8.8"
    )

    Test-Connection $Host -Count 4

}

# ==========================================================
# TRACE ROUTE
# ==========================================================

function trace {

    param(
        [string]$Host = "google.com"
    )

    tracert $Host

}

# ==========================================================
# DNS LOOKUP
# ==========================================================

function dns {

    param(
        [Parameter(Mandatory)]
        [string]$Host
    )

    Resolve-DnsName $Host

}

# ==========================================================
# PORT TEST
# ==========================================================

function port {

    param(

        [Parameter(Mandatory)]
        [string]$Host,

        [Parameter(Mandatory)]
        [int]$Port

    )

    Test-NetConnection -ComputerName $Host -Port $Port

}

# ==========================================================
# NETWORK CONNECTIONS
# ==========================================================

function netstatx {

    Get-NetTCPConnection |
    Sort-Object State,LocalPort |
    Format-Table `
        LocalAddress,
        LocalPort,
        RemoteAddress,
        RemotePort,
        State -Auto

}

# ==========================================================
# PROCESS MONITOR
# ==========================================================

function topcpu {

    Get-Process |
    Sort-Object CPU -Descending |
    Select-Object -First 15 `
        Name,
        Id,
        CPU,
        WS

}

# ==========================================================
# MEMORY HOGS
# ==========================================================

function topram {

    Get-Process |
    Sort-Object WS -Descending |
    Select-Object -First 15 `
        Name,
        Id,
        @{
            Name="Memory(MB)"
            Expression={
                [math]::Round($_.WS/1MB,2)
            }
        }

}

# ==========================================================
# DISK USAGE
# ==========================================================

function disks {

    Get-KDisk | ForEach-Object {

        Write-Host ""
        Write-Host "Drive $($_.Drive)" -ForegroundColor Cyan

        Draw-Bar $_.Drive $_.Percent

        Write-Host ("Used : {0} GB" -f $_.Used)
        Write-Host ("Free : {0} GB" -f $_.Free)
        Write-Host ("Total: {0} GB" -f $_.Total)

    }

}

# ==========================================================
# GPU INFORMATION
# ==========================================================

function gpu {

    Get-KGPU |
    Format-List *

}

# ==========================================================
# BATTERY STATUS
# ==========================================================

function battery {

    $b = Get-KBattery

    Write-Host ""
    Write-Host "Battery Status" -ForegroundColor Cyan
    Draw-Line

    Write-Host "Charge : $($b.Percent)%"
    Write-Host "Status : $($b.Status)"

}

# ==========================================================
# LIVE RESOURCE MONITOR
# ==========================================================

function monitor {

    while ($true) {

        Clear-Host

        $cpu = Get-KCPU
        $ram = Get-KMemory

        Write-Center "KHAJA RESOURCE MONITOR" Cyan

        Draw-Line

        Draw-Bar "CPU" $cpu.Load
        Draw-Bar "RAM" $ram.Percent

        foreach ($d in Get-KDisk) {

            Draw-Bar $d.Drive $d.Percent

        }

        Write-Host ""

        Write-Host ("TIME : {0}" -f (Get-Date))

        Start-Sleep 1

    }

}

# ==========================================================
# END OF PART 3
# ==========================================================
#############################################################
# KHAJA OS v4.0
# functions.ps1
# PART 4 / 5
#############################################################

# ==========================================================
# DIRECTORY SHORTCUTS
# ==========================================================

function desktop {

    Set-Location ([Environment]::GetFolderPath("Desktop"))

}

function downloads {

    Set-Location ([Environment]::GetFolderPath("UserProfile") + "\Downloads")

}

function documents {

    Set-Location ([Environment]::GetFolderPath("MyDocuments"))

}

function pictures {

    Set-Location ([Environment]::GetFolderPath("MyPictures"))

}

function videos {

    Set-Location ([Environment]::GetFolderPath("MyVideos"))

}

function music {

    Set-Location ([Environment]::GetFolderPath("MyMusic"))

}

function home {

    Set-Location $HOME

}

function projects {

    $path = Join-Path $HOME "Projects"

    if (!(Test-Path $path)) {
        New-Item -ItemType Directory -Path $path | Out-Null
    }

    Set-Location $path

}

# ==========================================================
# RELOAD PROFILE
# ==========================================================

function reload {

    . $PROFILE

    Write-Host ""
    Write-Host "KHAJA OS profile reloaded." -ForegroundColor Green

}

# ==========================================================
# FASTFETCH
# ==========================================================

function ff {

    if (Get-Command fastfetch -ErrorAction SilentlyContinue) {

        fastfetch

    }
    else {

        Write-Host "Fastfetch is not installed." -ForegroundColor Yellow

    }

}

# ==========================================================
# MATRIX EFFECT
# ==========================================================

function matrix {

    $chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%&*"

    while ($true) {

        $line = ""

        for ($i = 0; $i -lt 120; $i++) {

            $line += $chars[(Get-Random -Minimum 0 -Maximum $chars.Length)]

        }

        Write-Host $line -ForegroundColor Green

        Start-Sleep -Milliseconds 40

    }

}

# ==========================================================
# RANDOM PASSWORD
# ==========================================================

function password {

    param(
        [int]$Length = 20
    )

    $chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()"

    $result = ""

    1..$Length | ForEach-Object {

        $result += $chars[(Get-Random -Minimum 0 -Maximum $chars.Length)]

    }

    Write-Host $result -ForegroundColor Cyan

}

# ==========================================================
# RANDOM UUID
# ==========================================================

function uuid {

    [guid]::NewGuid().ToString()

}

# ==========================================================
# HASH FILE
# ==========================================================

function hashfile {

    param(

        [Parameter(Mandatory)]
        [string]$Path,

        [ValidateSet("MD5","SHA1","SHA256","SHA384","SHA512")]
        [string]$Algorithm = "SHA256"

    )

    Get-FileHash -Path $Path -Algorithm $Algorithm

}

# ==========================================================
# EXTRACT ZIP
# ==========================================================

function unzip {

    param(

        [Parameter(Mandatory)]
        [string]$ZipFile,

        [string]$Destination = "."

    )

    Expand-Archive `
        -Path $ZipFile `
        -DestinationPath $Destination `
        -Force

}

# ==========================================================
# CREATE ZIP
# ==========================================================

function zip {

    param(

        [Parameter(Mandatory)]
        [string]$Source,

        [Parameter(Mandatory)]
        [string]$Destination

    )

    Compress-Archive `
        -Path $Source `
        -DestinationPath $Destination `
        -Force

}

# ==========================================================
# FIND FILE
# ==========================================================

function findfile {

    param(

        [Parameter(Mandatory)]
        [string]$Name,

        [string]$Path = "."

    )

    Get-ChildItem `
        -Path $Path `
        -Recurse `
        -Force `
        -ErrorAction SilentlyContinue |
    Where-Object {
        $_.Name -like "*$Name*"
    }

}

# ==========================================================
# OPEN CURRENT DIRECTORY
# ==========================================================

function explorer {

    Start-Process .

}

# ==========================================================
# CLEAR TEMP FILES
# ==========================================================

function cleantemp {

    Write-Host ""
    Write-Host "Cleaning temporary files..." -ForegroundColor Yellow

    Remove-Item "$env:TEMP\*" `
        -Force `
        -Recurse `
        -ErrorAction SilentlyContinue

    Write-Host "Done." -ForegroundColor Green

}

# ==========================================================
# HELP MENU
# ==========================================================

function helpx {

    Clear-Host

    Write-Center "KHAJA OS v4.0 COMMAND CENTER" Cyan
    Draw-Line

    Write-Host ""
    Write-Host "SYSTEM"
    Write-Host "------"
    Write-Host "sys"
    Write-Host "monitor"
    Write-Host "clock"
    Write-Host "gpu"
    Write-Host "battery"
    Write-Host "disks"
    Write-Host "ff"

    Write-Host ""
    Write-Host "NETWORK"
    Write-Host "-------"
    Write-Host "weather"
    Write-Host "publicip"
    Write-Host "localip"
    Write-Host "speedtest"
    Write-Host "pingtest"
    Write-Host "trace"
    Write-Host "dns"
    Write-Host "port"

    Write-Host ""
    Write-Host "TOOLS"
    Write-Host "-----"
    Write-Host "password"
    Write-Host "uuid"
    Write-Host "zip"
    Write-Host "unzip"
    Write-Host "hashfile"
    Write-Host "findfile"
    Write-Host "matrix"
    Write-Host "cleantemp"

    Write-Host ""
    Write-Host "SHORTCUTS"
    Write-Host "---------"
    Write-Host "desktop"
    Write-Host "downloads"
    Write-Host "documents"
    Write-Host "pictures"
    Write-Host "videos"
    Write-Host "music"
    Write-Host "projects"
    Write-Host "home"
    Write-Host "reload"

    Draw-Line

}

# ==========================================================
# END OF PART 4
# ==========================================================
#############################################################
# KHAJA OS v4.0
# functions.ps1
# PART 5 / 5
#############################################################

# ==========================================================
# KHAJA OS COMMAND CENTER
# ==========================================================

function khaja {

    Clear-Host

    Write-Host ""
    Write-RGB "██████╗ ██╗  ██╗ █████╗      ██╗ █████╗ "
    Write-RGB "██╔══██╗██║ ██╔╝██╔══██╗     ██║██╔══██╗"
    Write-RGB "██████╔╝█████╔╝ ███████║     ██║███████║"
    Write-RGB "██╔══██╗██╔═██╗ ██╔══██║██   ██║██╔══██║"
    Write-RGB "██║  ██║██║  ██╗██║  ██║╚█████╔╝██║  ██║"
    Write-RGB "╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝ ╚════╝ ╚═╝  ╚═╝"

    Write-Host ""
    Write-Center "KHAJA OS v4.0 COMMAND CENTER" Cyan
    Write-Center "Ultimate PowerShell Experience" Yellow

    Draw-Line Cyan

    $cpu = Get-KCPU
    $ram = Get-KMemory
    $net = Get-KNetwork
    $bat = Get-KBattery

    Write-Host ""
    Write-Host (" CPU      : {0}" -f $cpu.Name) -ForegroundColor White
    Write-Host (" Cores    : {0}" -f $cpu.Cores) -ForegroundColor White
    Write-Host (" Threads  : {0}" -f $cpu.Threads) -ForegroundColor White
    Write-Host (" Network  : {0}" -f $net.Adapter) -ForegroundColor White
    Write-Host (" IP       : {0}" -f $net.IP) -ForegroundColor White
    Write-Host (" Battery  : {0}" -f $bat.Percent) -ForegroundColor White
    Write-Host (" Uptime   : {0}" -f (Get-KUptime)) -ForegroundColor White

    Write-Host ""

    Draw-Bar "CPU" $cpu.Load
    Draw-Bar "RAM" $ram.Percent

    foreach ($drive in Get-KDisk) {
        Draw-Bar $drive.Drive $drive.Percent
    }

    Draw-Line Cyan

    Write-Host ""
    Write-Host " QUICK COMMANDS" -ForegroundColor Green
    Write-Host ""

    Write-Host "  sys          monitor      ff           weather"
    Write-Host "  clock        gpu          battery     disks"
    Write-Host "  speedtest    publicip     localip     pingtest"
    Write-Host "  matrix       password     uuid        hashfile"
    Write-Host "  zip          unzip        findfile    explorer"
    Write-Host "  desktop      downloads    documents   projects"
    Write-Host "  reload       helpx"

    Write-Host ""

    Draw-Line Cyan

    Write-Center "KHAJA SHAIK" Green
    Write-Center "Happy Coding!" Yellow

    Write-Host ""

}

# ==========================================================
# SYSTEM DASHBOARD
# ==========================================================

function dashboard {

    while ($true) {

        Clear-Host

        Write-Center "KHAJA OS LIVE DASHBOARD" Cyan

        Draw-Line

        $cpu = Get-KCPU
        $ram = Get-KMemory
        $net = Get-KNetwork

        Write-Host ""
        Write-Host (" Time : {0}" -f (Get-Date))
        Write-Host (" IP   : {0}" -f $net.IP)
        Write-Host ""

        Draw-Bar "CPU" $cpu.Load
        Draw-Bar "RAM" $ram.Percent

        foreach ($disk in Get-KDisk) {
            Draw-Bar $disk.Drive $disk.Percent
        }

        Write-Host ""
        Write-Host "Press Ctrl+C to exit." -ForegroundColor Yellow

        Start-Sleep -Seconds 1

    }

}

# ==========================================================
# UPDATE CHECK
# ==========================================================

function kos-version {

    Write-Host ""
    Write-Host "KHAJA OS VERSION INFORMATION" -ForegroundColor Cyan

    Draw-Line

    Write-Host ("Version : {0}" -f $Global:KhajaVersion)
    Write-Host ("Build   : {0}" -f $Global:KhajaBuild)
    Write-Host ("PowerShell : {0}" -f $PSVersionTable.PSVersion)
    Write-Host ""

}

# ==========================================================
# BOOT ANIMATION
# ==========================================================

function Start-KhajaOS {

    Clear-Host

    Write-Host ""

    Write-RGB "██████████████████████████████████████████████"
    Write-RGB "             BOOTING KHAJA OS"
    Write-RGB "██████████████████████████████████████████████"

    Write-Host ""

    Start-RGBLoading -Title "Initializing System Components"

    Show-Spinner -Seconds 2 -Message "Loading Modules"

    khaja

}

# ==========================================================
# ALIASES
# ==========================================================

Set-Alias ksys        sys
Set-Alias kmonitor    monitor
Set-Alias kdash       dashboard
Set-Alias khelp       helpx
Set-Alias kclock      clock
Set-Alias kboot       Start-KhajaOS
Set-Alias kos         khaja
Set-Alias ver         kos-version
Set-Alias ip          localip
Set-Alias pubip       publicip
Set-Alias tempclean   cleantemp
Set-Alias pwdgen      password
Set-Alias ffetch      ff

# ==========================================================
# STARTUP MESSAGE
# ==========================================================

Write-Host ""
Write-Host "KHAJA OS v4.0 Functions Loaded Successfully!" -ForegroundColor Green
Write-Host "Type 'khaja' to open the Command Center." -ForegroundColor Cyan
Write-Host "Type 'helpx' for all available commands." -ForegroundColor Yellow
Write-Host ""

# ==========================================================
# END OF FILE
#############################################################