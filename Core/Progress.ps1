function Show-Bar {

    param(
        [string]$Name,
        [double]$Percent
    )

    $Length = 30
    $Filled = [math]::Round($Percent/100*$Length)

    $Bar = ("█" * $Filled) + ("░" * ($Length-$Filled))

    if($Percent -lt 50){
        $Color="Green"
    }
    elseif($Percent -lt 80){
        $Color="Yellow"
    }
    else{
        $Color="Red"
    }

    Write-Host ("{0,-10}" -f $Name) -NoNewline
    Write-Host $Bar -ForegroundColor $Color -NoNewline
    Write-Host (" {0,6:N1} %" -f $Percent)

}