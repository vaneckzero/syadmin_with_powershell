#retrieve url paramenter from command
param($url)

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
Write-Host "DNSFilter Auth Token:" -ForegroundColor Green
Write-Host "$dnsfilter_accessToken `n"

#query DNSFilter blockslists for domain, 181610 is the hardcode policy ID we're searching for this org
$search_headers = @{
    'accept' = 'application/json'
    'Authorization' = $dnsfilter_accessToken
}
$dnsfilter_domainQuery = Invoke-WebRequest -Uri https://api.dnsfilter.com/v1/policies?include_global_policies=false -Method GET -Headers $search_headers | ConvertFrom-Json
#$dnsfilter_domainQuery.data | Where-Object { $_.id -eq 181610 -and $_.attributes.blacklist_domains -like "fixcde.com"}
if ($dnsfilter_domainQuery.data.attributes[1].blacklist_domains -like "$url") #attributes[1] is the second policy in our tenant which is the one I want to search
    {write-host "domain $url found in DNSFilter blocklist" -ForegroundColor Green}
else 
    {write-host "domain $url not found in DNSFilter blocklist - adding..." -ForegroundColor Red
    $addDomain_postParams = @{domains="$url";policy_ids="181610"}
    $add_headers = @{
        'accept' = 'application/json'
        'Authorization' = $dnsfilter_accessToken
        'Content-Type' = 'application/json'
    }
    #verifying contents of hashtables
    Write-Output "Post Params: " $addDomain_postParams
    Write-Output "Add Headers: " $add_headers
    #$dnsfilter_addDomain = Invoke-WebRequest -Uri https://api.dnsfilter.com/v1/policies/bulk/add_blocklist_domains -Method POST -Body $addDomain_postParams -Headers $add_headers | ConvertFrom-Json
    #write-host $dnsfilter_addDomain -ForegroundColor Green
 }