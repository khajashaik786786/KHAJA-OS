$battery = Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue

if($battery){

Write-Host ("Battery : " + $battery.EstimatedChargeRemaining + "%") -ForegroundColor Green

}
else{

Write-Host "Battery : Desktop PC"

}