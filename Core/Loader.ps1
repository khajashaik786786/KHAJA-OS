# ===============================
# KHAJA OS v5 Loader
# ===============================

$Root = Split-Path $PSScriptRoot -Parent

# Load Core
Get-ChildItem "$Root\Core\*.ps1" |
Where-Object { $_.Name -ne "Loader.ps1" } |
Sort-Object Name |
ForEach-Object {
    . $_.FullName
}

# Load Modules
Get-ChildItem "$Root\Modules\*.ps1" |
Sort-Object Name |
ForEach-Object {
    . $_.FullName
}
. "$Root\Core\kh.ps1"