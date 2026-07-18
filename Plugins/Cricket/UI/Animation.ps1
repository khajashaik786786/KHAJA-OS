function Show-ProgressBar {

    param(
        [double]$Current,
        [double]$Target,
        [string]$Color="Green"
    )

    $width=40

    $percent=[math]::Min(1,$Current/$Target)

    $filled=[math]::Round($width*$percent)

    $empty=$width-$filled

    Write-Host "[" -NoNewline

    Write-Host ("█"* $filled) -ForegroundColor $Color -NoNewline

    Write-Host ("░"* $empty) -ForegroundColor DarkGray -NoNewline

    Write-Host "] $([math]::Round($percent*100))%"
}
function Start-Spinner{

    param($Text)

    $frames="|","/","-","\"

    while($true){

        foreach($f in $frames){

            Write-Host "`r$f $Text" -NoNewline

            Start-Sleep -Milliseconds 120

        }

    }

}