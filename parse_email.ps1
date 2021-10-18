$email = $args[0]
write-host -BackgroundColor green -foregroundcolor DarkBlue "----------To:----------"
Get-Content $email | Where-Object {$_ -like ‘*To:*’}
write-host -BackgroundColor green -foregroundcolor DarkBlue "----------From:----------"
Get-Content $email | Where-Object {$_ -like ‘*From:*’}
write-host -BackgroundColor green -foregroundcolor DarkBlue "----------Received----------"
Get-Content $email | Where-Object {$_ -like ‘Received:*’}
write-host -BackgroundColor green -foregroundcolor DarkBlue "----------Sender----------"
Get-Content $email | Where-Object {$_ -like ‘*sender*’}

#get iocs (urls, filenames, hashes, etc) and enrich with VT, etc
#should read file once and then parse variables