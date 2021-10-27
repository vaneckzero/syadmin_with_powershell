write-host -BackgroundColor White -ForegroundColor DarkGreen "parse_email.ps1"
write-host -BackgroundColor White -ForegroundColor DarkGreen "2021 Nick Hall @vaneckzero`n"

$email = get-content $args[0]

write-host -BackgroundColor green -foregroundcolor DarkBlue "----------To:----------"
    $email | Where-Object {$_ -like ‘To:*’}
    write-host "`n"

write-host -BackgroundColor green -foregroundcolor DarkBlue "----------From:----------"
    $email | Where-Object {$_ -like ‘From:*’}
    write-host "`n"

    write-host -BackgroundColor green -foregroundcolor DarkBlue "----------Subject:----------"
    $email | Where-Object {$_ -like ‘Subject:*’}
    write-host "`n"

write-host -BackgroundColor green -foregroundcolor DarkBlue "----------Received----------"
    $email | Where-Object {$_ -like ‘Received:*’}
    write-host "`n"

write-host -BackgroundColor green -foregroundcolor DarkBlue "----------Sender----------"
    $email | Where-Object {$_ -like ‘*sender*’}
    $senders = $email | Where-Object {$_ -like ‘*sender*’}
    $sender_ioc = $senders[0].Split(' ')[1]
    write-host "`n"

write-host -BackgroundColor green -foregroundcolor DarkBlue "----------Message Content----------"
    $email | select-string ‘Content-type: ’ -Context 0,3
    write-host "`n"

# get iocs (urls, filenames, hashes, etc) and enrich with VT, etc https://developers.virustotal.com/reference#files-scan
# help comment block with parameters, etc