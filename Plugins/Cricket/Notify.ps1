function Show-Notification($Title,$Message){

Add-Type -AssemblyName PresentationFramework

[System.Windows.MessageBox]::Show(

$Message,

$Title

)

}