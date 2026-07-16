function Update-IP {

    $Cache = Join-Path $PSScriptRoot "..\Cache"

    try {

        Invoke-RestMethod "https://api.ipify.org?format=json" |
        ConvertTo-Json |
        Set-Content "$Cache\ip.json"

        Write-Host "      ✓ Public IP Updated" -ForegroundColor Green

    }
    catch {

        Write-Host "      ✗ Public IP Failed" -ForegroundColor Red

    }

}