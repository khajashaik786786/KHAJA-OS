if(Test-Connection google.com -Count 1 -Quiet){

Write-Host "Internet : Connected" -ForegroundColor Green

}
else{

Write-Host "Internet : Offline" -ForegroundColor Red

}