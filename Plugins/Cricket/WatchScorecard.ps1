function Watch-Scorecard {

    param(
        [Parameter(Mandatory)]
        [int]$MatchId,

        [int]$Refresh = 10
    )

    $esc = [char]27

    try {

        # Hide cursor
        Write-Host "$esc[?25l" -NoNewline

        while ($true) {

            # Move to top-left instead of clearing screen
            $Host.UI.RawUI.CursorPosition =
                New-Object System.Management.Automation.Host.Coordinates(0,0)

            Show-CricbuzzScorecard `
                -MatchId $MatchId `
                -NoClear

            Write-Host ""
            Write-Host ("Refreshing every {0} seconds...  Press Ctrl+C to stop" -f $Refresh) `
                -ForegroundColor DarkGray

           for($i = $Refresh; $i -ge 1; $i--) {

    Write-Host -NoNewline "`rRefreshing in $i sec... Press Ctrl+C to stop "

    Start-Sleep 1
}

Write-Host ""
        }

    }
    finally {

        # Restore cursor
        Write-Host "$esc[?25h" -NoNewline
    }
}