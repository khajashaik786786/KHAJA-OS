$Global:MatchCacheTime = Get-Date "2000-01-01"
$Global:AllMatches = @()

function Update-MatchCache {

    Write-Host ""
    Write-Host "[ OK ] Updating Match Cache..." -ForegroundColor Green

    $Global:AllMatches = @()

    $offset = 0

    while($true){

        Write-Host "Loading Page $offset..."

        $url = "https://api.cricapi.com/v1/matches?apikey=$Global:CricketApiKey&offset=$offset"

        $json = Get-CricketJson $url

        if(!$json){
            break
        }

        if($json.data.Count -eq 0){
            break
        }

        $Global:AllMatches += $json.data

        $offset += 25

        Start-Sleep -Milliseconds 200

        if($offset -ge 200){
            break
        }

    }

    Write-Host ""
    Write-Host "Loaded $($Global:AllMatches.Count) Matches." -ForegroundColor Cyan
    $Global:MatchCacheTime = Get-Date

}
function Refresh-MatchCache{

    $age = (Get-Date) - $Global:MatchCacheTime

    if($age.TotalSeconds -ge 60){

        Update-MatchCache

    }

}

function Get-LiveMatches {

    return $Global:AllMatches | Where-Object {
        $_.matchStarted -eq $true -and
        $_.matchEnded -eq $false
    }

}

function Get-UpcomingMatches {

    return $Global:AllMatches | Where-Object {
        $_.matchStarted -eq $false
    }

}

function Get-CompletedMatches {

    return $Global:AllMatches | Where-Object {
        $_.matchEnded -eq $true
    }

}

function Get-IndiaMatches {

    return $Global:AllMatches | Where-Object {
        $_.name -match "India|IND"
    }

}