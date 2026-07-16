$Global:FavoriteTeams=@()

function Show-Favorites{

    Show-CricketTitle "FAVORITES"

    if($FavoriteTeams.Count -eq 0){

        Show-Warn "No favorite teams."

        Wait-Key

        return

    }

    foreach($team in $FavoriteTeams){

        Write-Host "⭐ $team"

    }

    Wait-Key

}

function Add-FavoriteTeam{

    $team=Read-Host "Enter Team Name"

    $Global:FavoriteTeams+=$team

    Show-OK "$team Added."

}