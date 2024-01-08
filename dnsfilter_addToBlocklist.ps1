#include dnsfilter_includes.ps1, need to set dnsfilter_user and dnsfilter_pass
. .\dnsfilter_includes.ps1

#testing credential inclusions
#write-output "User: $dnsfilter_user"
#write-output "Pass: $dnsfilter_pass"

#authentication and authorization w/ DNSFilter API
$auth_postParams = @{grant_type='http://auth0.com/oauth/grant-type/password-realm';client_id='zJ1WJHavuUFx89cConwlipxoOc2J3TVQ';realm='Username-Password-Authentication';audience='https://dnsfilter.auth0.com/mfa/';scope='enroll read:authenticators remove:authenticators offline_access openid picture name email';username="$dnsfilter_user";password="$dnsfilter_pass"}
Write-Output $auth_postParams

#$dnsfilter_authRequest = Invoke-WebRequest -Uri https://dnsfilter.auth0.com/oauth/token -Method POST -Body $auth_postParams
#write-output $dnsfilter_authRequest