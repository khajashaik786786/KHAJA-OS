function Invoke-CricbuzzAPI {

    param(
        [string]$Endpoint
    )

    $headers = @{
        "x-rapidapi-key"  = $Global:RapidApiKey
        "x-rapidapi-host" = $Global:RapidApiHost
    }

    try {

        Invoke-RestMethod `
            -Uri ("https://" + $Global:RapidApiHost + $Endpoint) `
            -Method GET `
            -Headers $headers

    }
    catch {

        Write-Host ""
        Write-Host "[ FAIL ] Cricbuzz API Error" -ForegroundColor Red
        Write-Host $_.Exception.Message

    }
}
function Invoke-CricbuzzLive {

    try {

        $headers = @{
            "x-rapidapi-key"  = $Global:RapidApiKey
            "x-rapidapi-host" = $Global:RapidApiHost
        }


        $response = Invoke-RestMethod `
        -Uri "https://cricbuzz-cricket.p.rapidapi.com/matches/v1/live" `
        -Headers $headers


        $matches = @()


        foreach($type in $response.typeMatches){

            foreach($series in $type.seriesMatches){

                if($series.seriesAdWrapper){

                    foreach($match in $series.seriesAdWrapper.matches){

                        $matches += $match

                    }
                }
            }
        }


        return $matches

    }
    catch {

        Write-Host "[Cricbuzz ERROR]" $_.Exception.Message

        return @()

    }

}