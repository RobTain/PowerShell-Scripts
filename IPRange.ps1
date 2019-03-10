<#
Ping every IP from 10.90.0 and 10.90.1 and collect arp entries
#>

for ($i = 1; $i -le 255; $i++) {
    ping 10.90.0.$i
    ping 10.90.1.$i
}


$arp = arp -a
$arp | Out-File C:\Users\rkoenig_admin\Desktop\arp.txt
