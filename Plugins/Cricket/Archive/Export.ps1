function Export-Score{

$url="https://api.cricapi.com/v1/currentMatches?apikey=2f08a5a3-d308-4f0c-9a04-d99ccf2317df&offset=0"

$json=Get-CricketJson $url

$json.data |

ConvertTo-Json |

Out-File "$HOME\Desktop\Scorecard.json"

Show-OK "Saved to Desktop."

}