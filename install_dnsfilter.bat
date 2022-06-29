@echo off
wmic product where name="DNSFilter Agent" call uninstall
mkdir C:\temp
powershell "Invoke-WebRequest -Uri 'https://download.dnsfilter.com/User_Agent/Windows/DNSFilter_Agent_Setup.msi' -OutFile 'C:\temp\DNSFilter_Agent_Setup.msi'"
msiexec /qn /i "C:\temp\DNSFilter_Agent_Setup.msi"