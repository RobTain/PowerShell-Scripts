<#Updaten des Winlogbeats auf eine neuere Version 

Vorgehensweise Programm: 
- Service stoppen
- Winlogbeat deinstallieren
- Winlogbeat (Ordner) loeschen
- neuer Winlogbeat Ordner hinzufuegen
- Winlogbeat installieren
- Winlogbeat starten


WICHTIG: Vor dem ausfuehren des Scripts TODO beachten!
(Anpassen des File-Paths mit der aktualisierten winlogbeat Version!)


#>

#TODO
$pathwinlogbeat = "C:\"


#checkPath Input
cd $pathwinlogbeat
$checkPath = DIR
if($checkPath.NAME -match "install-service-winlogbeat.ps1" -and $checkPath.NAME -match "uninstall-service-winlogbeat.ps1") {
$server = TODO write server like "Server-1", "Server-2"

foreach($s in $server) {
$s

New-PSSession $s
$session = Get-PSSession
Enter-PSSession $session.Id


# Dienst beenden
(Get-Service -ComputerName $s -Name winlogbeat).Stop()
$logger = "Dienst gestoppt"
$logger

# Dienst deinstallieren
Invoke-Command -ComputerName $s -FilePath "c:\Programme\winlogbeat\uninstall-service-winlogbeat.ps1"
$logger = "Dienst deinstalliert"
$logger

# Ordner löschen
Invoke-Command {Remove-Item -Path "C:\Programme\winlogbeat\" -Force -Recurse} -ComputerName $s
$logger = "Ordner gelöscht"
$logger

$logger = "Ordner zum Server kopieren"
$logger
# Update Ordner einfügen
Copy-Item $pathwinlogbeat -Destination "C:\Programme\winlogbeat" -ToSession $session -Recurse


# Dienst installieren
Invoke-Command -ComputerName $s -ScriptBlock{C:\Programme\winlogbeat\install-service-winlogbeat.ps1} 
$logger = "Dienst installieren"
$logger

# Dienst Starten
(Get-Service -ComputerName $s -Name winlogbeat).Start()
$logger = "Dienst starten"
$logger

Exit-PSSession 
Remove-PSSession $session.Id

}

} else {echo "InstallationsPfad von winlogbeat ist falsch gesetzt, bitte ueberpruefen! `n $ pathwinlogbeat = C:\PATH\TO\WINLOGBEAT"}


$logger = ": aktualisiert"
foreach($s in $server) {
$s + $logger
}
