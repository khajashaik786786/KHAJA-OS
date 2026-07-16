function Show-TestTheme {

    $theme = Get-KhTheme

    Write-Host ""
    Write-Host "========== KHAJA OS THEME =========="

    $theme.GetEnumerator() | ForEach-Object {

        Write-Host ("{0,-12}: {1}" -f $_.Key,$_.Value)

    }

}