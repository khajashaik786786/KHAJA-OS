# =====================================
# KHAJA OS v5 GLOBAL PLUGIN LOADER
# =====================================


function Import-KhPlugins {


$Root = Split-Path $PSScriptRoot -Parent


Write-Host ""
Write-Host "Loading Plugins..." -ForegroundColor Cyan



# ===============================
# SAVE EXISTING FUNCTIONS
# ===============================

$Before = Get-Command -CommandType Function |
Select-Object -ExpandProperty Name



# ===============================
# CRICKET ENGINE
# ===============================


$CricketRoot = Join-Path $Root "Plugins\Cricket"


if(Test-Path $CricketRoot)
{


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


$Path = Join-Path $CricketRoot $file



if(Test-Path $Path)
{


Write-Host "Loading Cricket\$file"


. $Path


}


}



# ===============================
# MOVE FUNCTIONS GLOBAL
# ===============================


$After = Get-Command -CommandType Function |
Select-Object -ExpandProperty Name



$NewFunctions = $After | Where-Object {
    $_ -notin $Before
}



foreach($func in $NewFunctions)
{


$command = Get-Command $func



Set-Item `
-Path "Function:global:$func" `
-Value $command.ScriptBlock



}



Write-Host ""
Write-Host "Cricket Engine Loaded 🏏" -ForegroundColor Green


}


}