function Watch-Scorecard {

param(
[int]$MatchId,
[int]$Refresh = 5
)


$esc=[char]27


Write-Host "$esc[?25l" -NoNewline


try {


while($true){


$pos = New-Object System.Management.Automation.Host.Coordinates(0,0)

$Host.UI.RawUI.CursorPosition=$pos


Show-CricbuzzScorecard $MatchId -NoClear


Write-Host ""

Write-Host "Refreshing in $Refresh sec... Press Ctrl+C to stop" `
-ForegroundColor DarkGray


Start-Sleep $Refresh


}


}

finally{


Write-Host "$esc[?25h" -NoNewline


}


}