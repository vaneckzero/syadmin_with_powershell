#include dnsfilter_includes.ps1, need to set dnsfilter_user and dnsfilter_pass
. .\dnsfilter_includes.ps1

#testing credential inclusions
#write-output "User: $dnsfilter_user"
#write-output "Pass: $dnsfilter_pass"

#authentication and authorization w/ DNSFilter API
$auth_postParams = @{grant_type='http://auth0.com/oauth/grant-type/password-realm';client_id='zJ1WJHavuUFx89cConwlipxoOc2J3TVQ';realm='Username-Password-Authentication';audience='https://dnsfilter.auth0.com/mfa/';scope='enroll read:authenticators remove:authenticators offline_access openid picture name email';username="$dnsfilter_user";password="$dnsfilter_pass"}
#Write-Output $auth_postParams
$dnsfilter_authRequest = Invoke-WebRequest -Uri https://dnsfilter.auth0.com/oauth/token -Method POST -Body $auth_postParams | ConvertFrom-Json
$dnsfilter_accessToken = $dnsfilter_authRequest.access_token

#query DNSFilter blockslists for domain, 181610 is the hardcode policy ID we're searching for this org
$search_headers = @{
    'accept' = 'application/json'
    'Authorization' = $dnsfilter_accessToken
}
$dnsfilter_domainQuery = Invoke-WebRequest -Uri https://api.dnsfilter.com/v1/policies?include_global_policies=false -Method GET -Headers $search_headers | ConvertFrom-Json
#$dnsfilter_domainQuery.data | Where-Object { $_.id -eq 181610 -and $_.attributes.blacklist_domains -like "fixcde.com"}
if ($dnsfilter_domainQuery.data.attributes[1].blacklist_domains -like "fixsdfsdfcde.com") #attributes[1] is the second policy in our tenant which is the one I want to search
    {write-output "domain found"}
else 
    {write-output "domain not found" }