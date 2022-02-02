######################################################
# - connect to netgate firewalls and retrieve WAN IP #
# - seach WAN IP via Shodan API, return JSON         #
# - parse and store results, send notification       #
# - schedule                                         #
######################################################

# You need to setup ssh authentication to the firewall with a public/private keypair. For OpenSSH see ssh-keygen.

. .\shodan_search_includes.ps1 #need to define $pf_user and $shodan_api_key

#define private IPs of firewalls
$pf_uc = "192.168.0.1"
$pf_martin = "192.168.1.1"
$pf_dresden = "192.168.2.1"
$pf_mckenzie = "192.168.3.1"
$pf_paris = "192.168.4.1"
$pf_bradford = "192.168.5.1"
$pf_kenton = "192.168.6.1"
$pf_ucip = "192.168.7.1"

#get public IPs from WAN interfaces (not all devices have static WAN IPs, thus the reason these aren't hardcoded)
$pf_uc_wan = ssh $pf_user@$pf_uc "ifconfig ix3 | grep 'netmask' | cut -d ' ' -f 2"
$pf_martin_wan = ssh $pf_user@$pf_martin "ifconfig mvneta2 | grep 'netmask' | cut -d ' ' -f 2"
$pf_dresden_wan = ssh $pf_user@$pf_dresden "ifconfig mvneta0 | grep 'netmask' | cut -d ' ' -f 2"
$pf_mckenzie_wan = ssh $pf_user@$pf_mckenzie "ifconfig mvneta0 | grep 'netmask' | cut -d ' ' -f 2"
$pf_paris_wan = ssh $pf_user@$pf_paris "ifconfig mvneta0 | grep 'netmask' | cut -d ' ' -f 2"
$pf_bradford_wan = ssh $pf_user@$pf_bradford "ifconfig pppoe | grep 'netmask' | cut -d ' ' -f 2"
$pf_kenton_wan = ssh $pf_user@$pf_kenton "ifconfig mvneta0 | grep 'netmask' | cut -d ' ' -f 2"
$pf_ucip_wan = ssh $pf_user@$pf_ucip "ifconfig mvneta2 | grep 'netmask' | cut -d ' ' -f 2"

write-output "uc wan ip is: $pf_uc_wan"
write-output "martin wan ip is: $pf_martin_wan"
write-output "dresden wan ip is: $pf_dresden_wan"
write-output "mckenzie wan ip is: $pf_mckenzie_wan"
write-output "paris wan ip is: $pf_paris_wan"
write-output "bradford wan ip is: $pf_bradford_wan"
write-output "kenton wan ip is: $pf_kenton_wan"
write-output "ucip wan ip is: $pf_ucip_wan" 

#write-host "pf_uc_wan is a " $pf_uc_wan.GetType().name

#$pf_uc_shodan_info = curl -X GET "https://api.shodan.io/shodan/host/${pf_uc_wan}?key=${shodan_api_key}"
#$pf_uc_shodan_info | ConvertFrom-Json