function kh {

param(

[string]$Command,

[string]$Option,

[string]$Argument

)


switch ($Command.ToLower()) {


# =========================
# DASHBOARD
# =========================

"dashboard" {

    Show-Dashboard

}



# =========================
# SYSTEM
# =========================

"system" {

    Show-System

}


"doctor" {

    Show-Doctor

}


"clock" {

    Show-Clock

}


"security" {

    Show-Security

}



# =========================
# NETWORK
# =========================

"network" {

    Show-NetworkCenter

}



# =========================
# WEATHER
# =========================

"weather" {

    Show-WeatherCenter

}



# =========================
# NEWS
# =========================

"news" {

    Show-NewsCenter

}



# =========================
# TELUGU NEWS
# =========================

"telugu" {


switch($Option.ToLower()){


"ap" {

Show-APNews

}


"ts" {

Show-TSNews

}


"jobs" {

Show-TeluguJobs

}


"tech" {

Show-TechNews

}


"cinema" {

Show-CinemaNews

}


"sports" {

Show-SportsNews

}


default {

Show-TeluguNews

}


}


}




# =========================
# CRICKET ENGINE
# =========================

"cricket" {


switch($Option.ToLower()) {



# LIVE MATCHES

"live" {

    Show-LiveMatches

}




# FULL SCORECARD

"score" {

    Show-Scorecard

}




# WATCH LIVE SCORECARD

"watch" {


$matches = Invoke-CricbuzzLive


if(!$matches)
{

    Show-Error "No Live Matches"

    return

}



Write-Host ""

Write-Host "LIVE MATCHES" -ForegroundColor Cyan


for($i=0;$i -lt $matches.Count;$i++)
{


Write-Host ""

Write-Host "[$($i+1)] $($matches[$i].matchInfo.team1.teamName) vs $($matches[$i].matchInfo.team2.teamName)" -ForegroundColor Yellow


}



$choice = Read-Host "Select Match"



if(($choice -as [int]) -lt 1 -or ($choice -as [int]) -gt $matches.Count)
{

    Show-Error "Invalid Match"

    return

}



$id = $matches[$choice-1].matchInfo.matchId



Watch-Scorecard $id 5


}





# MATCH VIEWER

"match" {


if(!$Argument)
{

Write-Host ""

Write-Host "Usage:"
Write-Host "kh cricket match <matchid>"

return

}



Show-CricbuzzMatch $Argument


}





default {


Show-Cricket


}



}


}





# =========================
# UPDATE
# =========================

"update" {

Update-Khaja

}





# =========================
# UI
# =========================


"theme" {

Show-TestTheme

}


"top" {

Show-Top

}


"about" {

Show-About

}





# =========================
# HELP
# =========================

default {


Write-Host ""

Write-Host "========== KHAJA OS ==========" -ForegroundColor Cyan

Write-Host ""



Write-Host "SYSTEM"

Write-Host " kh dashboard"

Write-Host " kh system"

Write-Host " kh doctor"

Write-Host " kh security"

Write-Host " kh clock"



Write-Host ""

Write-Host "TOOLS"

Write-Host " kh weather"

Write-Host " kh network"

Write-Host " kh news"



Write-Host ""

Write-Host "CRICKET"

Write-Host " kh cricket"

Write-Host " kh cricket live"

Write-Host " kh cricket score"

Write-Host " kh cricket watch"

Write-Host " kh cricket match <id>"



Write-Host ""



}



}


}