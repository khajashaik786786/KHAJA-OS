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

        Write-Host "[ FAIL ] Cricbuzz API Error" -ForegroundColor Red
        Write-Host $_.Exception.Message

    }

}