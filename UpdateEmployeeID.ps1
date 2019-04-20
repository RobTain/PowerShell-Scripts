# Variablen
$server = TODO write server IP or name


# ----------------------------- UpdateUser Script ----------------------------------
#
# Programmablauf:
#
# - Auslesen aus einer Text Datei
# - Update der User per Schleife (Setzen von employeeID)
# ----------------------------------------------------------------------------------

# Read Text Input
$Input = Get-Content -Path 'C:\Scripte\DATA\Alle IDs zu Namen.txt' 

# Get Line Count
$count = Get-Content -Path 'C:\Scripte\DATA\Alle IDs zu Namen.txt'| measure -Line

# Create RDP Session with DC Server
New-PSSession $server
$session = Get-PSSession
Enter-PSSession $session.Id


# For-Loop get all users
for ($i = 1; $i -le $count.Lines-1; $i++) {
$line = $Input[$i].Split("`t")
$id = $line.Get(0)
$username = $line.Get(1)

Invoke-Command -ComputerName $server -ScriptBlock{
Import-Module activedirectory
$user = Get-ADUser -Filter {SamAccountName -eq $Using:username}
Set-ADUser -Identity $Using:username -employeeID $Using:id
}

}

# Close RDP Session 
Exit-PSSession
Remove-PSSession $session.Id
