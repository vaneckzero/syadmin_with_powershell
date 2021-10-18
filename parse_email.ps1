$email = get-content $args[0]

write-host -BackgroundColor green -foregroundcolor DarkBlue "----------To:----------"
    $email | Where-Object {$_ -like ‘To:*’}
    write-host "`n"

write-host -BackgroundColor green -foregroundcolor DarkBlue "----------From:----------"
    $email | Where-Object {$_ -like ‘From:*’}
    write-host "`n"

write-host -BackgroundColor green -foregroundcolor DarkBlue "----------Received----------"
    $email | Where-Object {$_ -like ‘Received:*’}
    write-host "`n"

write-host -BackgroundColor green -foregroundcolor DarkBlue "----------Sender----------"
    $email | Where-Object {$_ -like ‘*sender*’}
    write-host "`n"

write-host -BackgroundColor green -foregroundcolor DarkBlue "----------Message Info----------"
    $email | select-string ‘message_boundary’ -Context 0,4
    write-host "`n"

# should read file once and then parse variables
# get iocs (urls, filenames, hashes, etc) and enrich with VT, etc https://developers.virustotal.com/reference#files-scan
# help comment block with parameters, etc