# =====================================
# KHAJA OS Cricket Plugin Loader
# =====================================


function Import-KhPlugins {


$Root = Split-Path $PSScriptRoot -Parent

$CricketPath = "$Root\Plugins\Cricket"


Write-Host ""
Write-Host "Loading Cricket Engine..." -ForegroundColor Cyan


$CricketFiles = @(

    "Config.ps1"

    "Utils.ps1"

    "Providers\Cricbuzz.ps1"

    "UI\DrawBox.ps1"
    "UI\Tables.ps1"
    "UI\Animation.ps1"

    "Live.ps1"

    "Scorecard.ps1"

    "WatchScorecard.ps1"

    "MatchViewer.ps1"

    "Dashboard.ps1"

    "Cricket.ps1"

)



foreach($file in $CricketFiles)
{

    $FullPath = Join-Path $CricketPath $file


    if(Test-Path $FullPath)
    {

        Write-Host "Loading Cricket\$file"

        . $FullPath

    }

}



Write-Host ""
Write-Host "Cricket Engine Loaded 🏏" -ForegroundColor Green


}