function Show-NetworkCenter {

    Write-Host ""
    Write-Host "================ NETWORK =================" -ForegroundColor Cyan

    # Local IP
    $ip = (Get-NetIPAddress -AddressFamily IPv4 |
        Where-Object {
            $_.IPAddress -notlike "169.*" -and
            $_.IPAddress -ne "127.0.0.1"
        } |
        Select-Object -First 1).IPAddress

    # Adapter
    $adapter = Get-NetAdapter |
        Where-Object Status -eq "Up" |
        Select-Object -First 1

    # Gateway
    $gateway = (Get-NetRoute -DestinationPrefix "0.0.0.0/0" |
        Select-Object -First 1).NextHop

    # DNS
    $dns = (Get-DnsClientServerAddress -AddressFamily IPv4 |
        Select-Object -First 1).ServerAddresses -join ", "

    Write-Host "Adapter : $($adapter.Name)"
    Write-Host "Status  : $($adapter.Status)"
    Write-Host "Speed   : $($adapter.LinkSpeed)"
    Write-Host "IP      : $ip"
    Write-Host "Gateway : $gateway"
    Write-Host "DNS     : $dns"

}