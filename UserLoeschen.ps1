 # Eingangsparameter
 param (
    [string]$username = "username",
    [string]$id = "id"
     )

# Logger
$loggerPath = "C:\Temp\Log"
$date = get-date -format "yyyy-MM-dd-HH-mm"
$loggerFile = ("Log_" + $date + ".log")
$logdata = $loggerPath + "\" + $loggerFile

function Write-Log([string]$logtext, [int]$level=0)
{
	$logdate = get-date -format "yyyy-MM-dd HH:mm:ss"
	if($level -eq 0)
	{
		$logtext = "[INFO] " + $logtext
		$text = "["+$logdate+"] - " + $logtext
		Write-Host $text
	}
	if($level -eq 1)
	{
		$logtext = "[WARNING] " + $logtext
		$text = "["+$logdate+"] - " + $logtext
		Write-Host $text -ForegroundColor Yellow
	}
	if($level -eq 2)
	{
		$logtext = "[ERROR] " + $logtext
		$text = "["+$logdate+"] - " + $logtext
		Write-Host $text -ForegroundColor Red
	}
	$text >> $logdata
}

 # Funktion Benutzer finden
 # Sucht den Nutzer anhand des samaccountname heraus und returned diesen.
 function findUser([string]$username) {
    return Get-ADUser -ldapfilter "(SAMaccountname=$username)" -properties *  
 }

 # Main Funktion
    if ($username -eq "username" -and $id -eq "id") {
        Write-Log "Programm kann nicht ausgeführt werden, da Parameter fehlen." 2
    } else {
        Write-Log "User finden" 0
        $user = findUser $username
        Write-Log "Gefundener User wird überprüft" 0
        if ($user -eq $NULL) {
            Write-Log "User wurde nicht gefunden. Programm wird beendet" 2
            exit 1 
        } 

        Write-Log "Vergleiche EmployeeID auf die ID aus der Datenbank" 0
        if ($user.employeeid -ne $id) {
            Write-Log "EmployeeID entspricht nicht der ID aus der Datenbank. Programm wird beendet" 2
            exit 1 
        }

        Write-Log "User $username löschen." 0
        Remove-ADUser -Identity $username -Confirm:$false 
        exit 0
    }









 