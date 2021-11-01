write-host -BackgroundColor White -ForegroundColor DarkGreen "parse_email.ps1"
write-host -BackgroundColor White -ForegroundColor DarkGreen "Nick Hall @vaneckzero (2021)`n"

$email = get-content $args[0]

if (!$email){
     write-host "Usage: parse_email.ps1 emlfile"
 }
else {
write-host -BackgroundColor green -foregroundcolor DarkBlue "----------To:----------"
    $email | Where-Object {$_ -like ‘To:*’}

write-host -BackgroundColor green -foregroundcolor DarkBlue "----------From:----------"
    $email | Where-Object {$_ -like ‘From:*’ -or $_ -like 'Return-Path:*'}

    write-host -BackgroundColor green -foregroundcolor DarkBlue "----------Subject:----------"
    $email | Where-Object {$_ -like ‘Subject:*’}

write-host -BackgroundColor green -foregroundcolor DarkBlue "----------Received----------"
    $email | Where-Object {$_ -like ‘Received:*’}

write-host -BackgroundColor green -foregroundcolor DarkBlue "----------Sender----------"
    $email | Where-Object {$_ -like ‘*sender*’}
    $senders = $email | Where-Object {$_ -like ‘*sender*’}
    $sender_ioc = $senders[0].Split(' ')[1]

write-host -BackgroundColor green -foregroundcolor DarkBlue "----------Message Content----------"
<<<<<<< HEAD
    #$email | select-string ‘Content-type: ’ -Context 0,3
    $email | Where-Object {$_ -like ‘*Content-type: *’}

write-host -BackgroundColor green -foregroundcolor DarkBlue "----------Links----------"
    $email | select-string ‘img src’ -Context 0,3
    $email | select-string ‘href’ -Context 0,3
    #$email | Where-Object {$_ -like ‘*img src*’}
    #$email | Where-Object {$_ -like ‘*href*’}

=======
    $email | select-string ‘Content-type: ’ -Context 0,3
 }
>>>>>>> f0feced70418540cb645039b84161df59859b027
# get iocs (urls, filenames, hashes, etc) and enrich with VT, etc https://developers.virustotal.com/reference#files-scan
# help comment block with parameters, etc