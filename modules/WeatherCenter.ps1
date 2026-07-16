function Show-WeatherCenter {

    Show-KhHeader "KHAJA WEATHER ENGINE"

    Start-KhAnimation @(
        "Initializing Weather Engine",
        "Loading Weather Cache",
        "Parsing Weather Data",
        "Preparing Dashboard"
    )

    try {

        $CacheFile = Join-Path $PSScriptRoot "..\Cache\weather.json"

        if (!(Test-Path $CacheFile)) {

            Show-Warn "Weather cache not found"
            Show-Warn "Run: kh update"

            Show-KhFooter
            return
        }

        $Weather = Get-Content $CacheFile -Raw | ConvertFrom-Json

        $Current = $Weather.current_condition[0]

        $Temp      = $Current.temp_C
        $Feels     = $Current.FeelsLikeC
        $Humidity  = $Current.humidity
        $Wind      = $Current.windspeedKmph
        $Condition = $Current.weatherDesc[0].value

        switch -Regex ($Condition.ToLower()) {

            "sun|clear"      { $Icon = "☀" }
            "cloud"          { $Icon = "☁" }
            "rain|drizzle"   { $Icon = "🌧" }
            "thunder"        { $Icon = "⛈" }
            "mist|fog|haze"  { $Icon = "🌫" }
            "snow"           { $Icon = "❄" }
            default          { $Icon = "🌍" }
        }

        Show-OK "Weather cache loaded"
        Start-Sleep -Milliseconds 150

        Show-OK "Forecast ready"
        Start-Sleep -Milliseconds 150

        Show-KhSection "Current Weather"

        Write-Host ""

        Write-Host "🌡 Temperature : " -NoNewline
        Write-Host "$Temp °C" -ForegroundColor Yellow

        Write-Host "🤒 Feels Like : " -NoNewline
        Write-Host "$Feels °C" -ForegroundColor DarkYellow

        Write-Host "💧 Humidity   : " -NoNewline
        Write-Host "$Humidity %" -ForegroundColor Cyan

        Write-Host "🌬 Wind Speed : " -NoNewline
        Write-Host "$Wind km/h" -ForegroundColor Green

        Write-Host "$Icon Condition : " -NoNewline
        Write-Host "$Condition" -ForegroundColor Magenta

        Show-KhFooter

    }
    catch {

        Show-Fail "Unable to read weather cache"

    }

}