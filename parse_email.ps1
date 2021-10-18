$email = $args[0]
write-host -BackgroundColor green -foregroundcolor DarkBlue "----------To:----------"
Get-Content $email | Where-Object {$_ -like ‘To:*’}
write-host -BackgroundColor green -foregroundcolor DarkBlue "----------From:----------"
Get-Content $email | Where-Object {$_ -like ‘From:*’}
write-host -BackgroundColor green -foregroundcolor DarkBlue "----------Received----------"
Get-Content $email | Where-Object {$_ -like ‘Received:*’}
write-host -BackgroundColor green -foregroundcolor DarkBlue "----------Sender----------"
Get-Content $email | Where-Object {$_ -like ‘*sender*’}
write-host -BackgroundColor green -foregroundcolor DarkBlue "----------Message Info----------"
Get-Content $email | select-string ‘message_boundary’ -Context 0,4

# should read file once and then parse variables
# get iocs (urls, filenames, hashes, etc) and enrich with VT, etc https://developers.virustotal.com/reference#files-scan
# help comment block with parameters, etc