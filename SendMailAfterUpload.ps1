$log = Get-Content C:\Temp\filezilla.log

$EmailFrom = ""
$password = ""
$reciever1 = ""
$reciever2 = ""
$reciever43 = ""

$SMTPServer = "smtp.gmail.com"
$SMTPClient = New-Object Net.Mail.SmtpClient($SmtpServer, 587)
$SMTPClient.EnableSsl = $true
 
$SMTPClient.Credentials = New-Object System.Net.NetworkCredential($EmailFrom, $password);
 

#get every upload
foreach($line in $log) {
  if ($line -like "*Starte Upload von*") {
    # get last element (Path)
    $line = $line.Split("\")[-1]
    # send mail
    $Subject = "Plex ADD: " + $line   
    $Body = "Dies ist eine automatisch generierte Mail von Robsoft.`r`nAktion: $Subject `r`nSkynet - die freundliche KI aus der Nachbarschaft"
    $SMTPClient.Send($EmailFrom, $reciever1, $Subject, $Body)
    $SMTPClient.Send($EmailFrom, $reciever2, $Subject, $Body)
    $SMTPClient.Send($EmailFrom, $reciever3, $Subject, $Body)
  }
}

#delete content from log
Clear-Content C:\Temp\filezilla.log
 
