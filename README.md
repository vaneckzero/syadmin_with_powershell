# sysadmin_with_powershell
powershell scripts for various system administration tasks

##
- diagnose_latency.ps1 - Will run continuous timestamped traceroutes to targetip and output trace_targetip.txt in same directory
- find_dns_server.ps1 - Search net ip config for specific dns server
- parse_email.ps1 - breaks eml file into specific chunks for quick parsing, intend on submitting various bits for enrichment w/ threat intel 
  - to use API lookups place these items in parse_email_includes.ps1 in the same dir, add appropriate API info
  - $censys_id = ""
  - $censys_key = ""
  - $virustotal_key = ""
- ping_forever.ps1 - continuous ping and timestamps output to file
