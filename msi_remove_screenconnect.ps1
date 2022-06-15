##############################################
#  remove old screenconnect and install new  #
##############################################

#find msi guids
$sc19guid = (get-wmiobject Win32_Product | where-object Name -like "*screenconnect*" | where-object LocalPackage -notlike "*c:\windows*").IdentifyingNumber
$sc21guid = (get-wmiobject Win32_Product | where-object Name -like "*screenconnect*" | where-object LocalPackage -like "*c:\windows*").IdentifyingNumber

#uninstall both 
msiexec.exe /x "$sc19guid" /QN /L*V "C:\sc_uninstall.log" REBOOT=R
msiexec.exe /x "$sc21guid" /QN /L*V "C:\sc_uninstall.log" REBOOT=R

#install 22.1
msiexec /i "\\ucnas\netshare\ConnectWise Installers\westan_connectwise_02220222.msi" /quiet