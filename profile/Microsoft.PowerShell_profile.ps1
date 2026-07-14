# Load startup modules
. "$PSScriptRoot\animation.ps1"
. "$PSScriptRoot\startup.ps1"
. "$PSScriptRoot\dashboard.ps1"
. "$PSScriptRoot\functions.ps1"

# Terminal icons
Import-Module Terminal-Icons -ErrorAction SilentlyContinue

# PSReadLine
if (Get-Module -ListAvailable PSReadLine) {
    Import-Module PSReadLine
    Set-PSReadLineOption -PredictionSource History
    Set-PSReadLineOption -PredictionViewStyle ListView
}

# Oh My Posh
$theme = "$HOME\Documents\PowerShell\khaja-cyberpunk.omp.json"
if (Test-Path $theme) {
    oh-my-posh init pwsh --config $theme | Invoke-Expression
}
