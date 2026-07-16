function Show-Cricket {

    Show-CricketDashboard

    $choice = Read-Host "Choose"

    switch ($choice) {

        "1"  { Show-LiveMatches }

        "2"  { Show-TodayMatches }

        "3"  { Show-UpcomingMatches }

        "4"  { Show-Series }

        "5"  { Show-IPL }

        "6"  { Show-WorldCup }

        "7"  { Show-Rankings }

        "8"  { Show-Points }

        "9"  { Search-Player }

        "10" { Show-Scorecard }

        "11" { Show-CricketNews }

        "12" { Show-IndiaMatches }

        "13" { Show-Favorites }

        "14" { Start-WatchMode }

        "15" { Show-CricketSettings }

        default { return }

    }

}