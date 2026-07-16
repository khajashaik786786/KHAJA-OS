function kh {

    param(

    [string]$Command,

    [string]$Option,

    [string]$Argument

)

    switch ($Command.ToLower()) {

        "dashboard" { Show-Dashboard }

        "weather" { Show-WeatherCenter }

        "network" { Show-NetworkCenter }
        "cricket" {

    switch ($Option.ToLower()) {

        "live" { Show-LiveMatches }

        "today" { Show-TodayMatches }

        "series" { Show-Series }

        "rankings" { Show-Rankings }

        "points" { Show-Points }

        "news" { Show-CricketNews }

        "score" { Show-Scorecard }

        "venues" { Show-Venues }

        "player" { Search-Player $Argument }

        default { Show-Cricket }

    }

}

        "news" { Show-NewsCenter }
"telugu" {

    switch ($Option.ToLower()) {

        "ap"      { Show-APNews }
        "ts"      { Show-TSNews }
        "jobs"    { Show-TeluguJobs }
        "tech"    { Show-TechNews }
        "cinema"  { Show-CinemaNews }
        "sports"  { Show-SportsNews }

        default   { Show-TeluguNews }
    }
}

        "update" { Update-Khaja }

        "theme" { Show-TestTheme }
        "top" { Show-Top }

        "about" { Show-About }

        "doctor" { Show-Doctor }

        "system" { Show-System }

        "clock" { Show-Clock }
        "security" { Show-Security }

        default {

            Write-Host ""
            Write-Host "========== KHAJA OS ==========" -ForegroundColor Cyan
            Write-Host ""
            
            Write-Host "kh top"
            Write-Host "kh about"
            Write-Host "kh dashboard"
            Write-Host "kh weather"
            Write-Host "kh network"
            Write-Host "kh news"
            Write-Host "kh telugu"
            Write-Host "kh update"
            Write-Host "kh theme"
            Write-Host "kh doctor"
            Write-Host "kh system"
            Write-Host "kh clock"
            Write-Host "kh security"
            Write-Host "kh cricket"

            Write-Host ""
        }
    }
}