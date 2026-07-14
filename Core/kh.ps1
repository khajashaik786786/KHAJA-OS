function kh {

    param(
        [string]$Command
    )

    switch ($Command.ToLower()) {

        "weather" { Show-Weather }

        "news" { Show-News }

        "jobs" { Show-Jobs }

        "network" { Show-Network }

        "monitor" { Show-Monitor }

        "eda" { Show-EDA }

        "ai" { Show-AI }

        default {

            Write-Host ""
            Write-Host "========================="
            Write-Host "     KHAJA OS v5"
            Write-Host "========================="
            Write-Host ""
            Write-Host "Available Commands:"
            Write-Host "kh weather"
            Write-Host "kh news"
            Write-Host "kh jobs"
            Write-Host "kh network"
            Write-Host "kh monitor"
            Write-Host "kh eda"
            Write-Host "kh ai"
            Write-Host ""
        }
    }
}
