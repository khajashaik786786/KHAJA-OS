function Update-Weather {

    $Cache = Join-Path $PSScriptRoot "..\Cache"

    try {

        Invoke-RestMethod "https://wttr.in/?format=j1" |
        ConvertTo-Json -Depth 20 |
        Set-Content "$Cache\weather.json"

        Write-Host "      ✓ Weather Updated" -ForegroundColor Green

    }
    catch {

        Write-Host "      ✗ Weather Failed" -ForegroundColor Red

    }

}

function Show-WeatherCenter {

    $file = Join-Path $PSScriptRoot "..\Cache\weather.json"

    if(!(Test-Path $file)){
        Write-Host "Run: kh update first"
        return
    }

    $w = Get-Content $file | ConvertFrom-Json

    Write-Host ""
    Write-Host "=============== WEATHER ===============" -ForegroundColor Cyan
    Write-Host "🌡 Temperature : $($w.current_condition.temp_C) °C"
    Write-Host "🤒 Feels Like : $($w.current_condition.FeelsLikeC) °C"
    Write-Host "💧 Humidity   : $($w.current_condition.humidity) %"
    Write-Host "🌬 Wind Speed : $($w.current_condition.windspeedKmph) km/h"
    Write-Host "☁ Condition  : $($w.current_condition.weatherDesc.value)"
}