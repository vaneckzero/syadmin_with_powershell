#####################################
#    addDomainToBlocklist.ps1       #
#     vaneckzero@gmail.com          #
#  add specified url to DNSFilter   #
#    and Defender blocklists        #
#####################################

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
Write-Host $dnsfilter_accessToken.substring(0,10)"...`n"

#query DNSFilter blockslists for domain, 181610 is the hardcode policy ID we're searching for this org
$search_headers = @{
    'accept' = 'application/json'
    'Authorization' = $dnsfilter_accessToken
}
$dnsfilter_domainQuery = Invoke-WebRequest -Uri https://api.dnsfilter.com/v1/policies?include_global_policies=false -Method GET -Headers $search_headers | ConvertFrom-Json
#$dnsfilter_domainQuery.data | Where-Object { $_.id -eq 181610 -and $_.attributes.blacklist_domains -like "fixcde.com"}
if ($dnsfilter_domainQuery.data.attributes[1].blacklist_domains -like "$url") #attributes[1] is the second policy in our tenant which is the one I want to search
    {write-host "Domain $url found in DNSFilter blocklist" -ForegroundColor Green}
else 
    {write-host "Domain $url NOT found in DNSFilter blocklist - adding..." -ForegroundColor Red
    $addDomain_postParams = @{domains="$url";policy_ids="181610"}
    $add_headers = @{
        'accept' = 'application/json'
        'Authorization' = $dnsfilter_accessToken
        'Content-Type' = 'application/json'
    }
    #verifying contents of hashtables
    #Write-Output "Post Params: " ($addDomain_postParams | ConvertTo-Json)
    #Write-Output "Add Headers: " $add_headers
    
    #add domain to blocklist
    $dnsfilter_addDomain = Invoke-WebRequest -Uri https://api.dnsfilter.com/v1/policies/bulk/add_blocklist_domains -Method POST -Body ($addDomain_postParams|ConvertTo-Json) -Headers $add_headers
    write-host $dnsfilter_addDomain -ForegroundColor Green
 }

 # Azure Defender for Business
 #check for Microsoft.Graph.Beta powershell module
 if (-not (get-installedmodule Microsoft.Graph.Beta)){
    Write-Host "Microsoft.Graph.Beta Powershell module not found - please install using 'Install-Module Microsoft.Graph.Beta'" -ForegroundColor Red
    exit
 }

 #connecting Powershell modeul to Microsoft Graph API with appropriate scope
 connect-MgGraph -Scopes "ThreatIndicators.ReadWrite.OwnedBy" -NoWelcome
 if (Get-MgBetaSecurityTiIndicator | Select-Object -Property DomainName | Select-String -Pattern "$url"){
    write-host "Domain $url found in Defender indicators" -ForegroundColor Green
 }
 else {
    write-host "Domain $url NOT found in Defender indicators - adding..." -ForegroundColor Red
    $params = @{
            Action = "block"
            Confidence = 100
            Description = "$url added by addDomainToBlocklist.ps1"
		    DomainName = "$url"
			ExpirationDateTime = [System.DateTime]::Parse("2040-03-01T21:43:37.5031462+00:00")
			Severity = 3
			ThreatType = "MaliciousURL"
			TargetProduct = "Microsoft Windows Defender ATP"
        }
    #$newDefenderIndicator = New-MgBetaSecurityTiIndicator -BodyParameter $params
    $params
 }